<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\Product;
use App\Form\ProductType;
use App\Entity\OrderDetail;
use App\Repository\OrderRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\OrderDetailRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Config\Definition\Exception\Exception;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;


/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    #[Route('/', name: 'product_index')]
    public function viewtestw(ProductRepository $productRepository, Request $request)
    {
        $searchValue = $request->get('searchValue') ? $request->get('searchValue') : '';
        $products = $productRepository->searchProducts($searchValue);
        return $this->render(
            'product/index.html.twig',
            [
                'products' => $products
            ]
        );
    }

    #[Route('/detail/{id}', name: 'product_show')]
    public function viewProductDetail($id, productRepository $productRepository)
    {
        $product = $productRepository->find($id);
        if ($product == null) {
            $this->addFlash('Error', 'Product not found');
            return $this->redirectToRoute('product_index');
        }
        return $this->render(
            'product/show.html.twig',
            [
                'product' => $product
            ]
        );
    }
    #[Route('/crud', name: 'crud_product_index', methods: ['GET'])]
    public function index(EntityManagerInterface $em): Response
    {
        $product = $em->getRepository(Product::class)->findAll();
        return $this->render('crud_product/index.html.twig', [
            'list' => $product,
        ]);
    }

    #[Route('/crud/create', name: 'crud_product_create')]
    public function create(Request $request, ManagerRegistry $doctrine): Response
    {
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $file = $form->get('imgurl')->getData();
            $imgName = uniqid(); //uniqid : tạo ra string duy nhất
            
            $imgExtension = $file->guessExtension();
            
            $imageName = $imgName . "." . $imgExtension;
            
            try {
                $file->move(
                    $this->getParameter('product_imgurl'),
                    $imageName
                    
                );
            } catch (FileException $e) {
                throwException($e);
            }
            
            $product->setImgurl($imageName);
            //gọi đến Manager (Doctrine) để add object (row in table)
            $entityManager = $doctrine->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('Info', 'Add product successfully !');
            return $this->redirectToRoute('crud_product_index');
        }

        return $this->render('crud_product/create.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/crud/update/{id}', name: 'crud_product_update')]
    public function update(Request $request, ManagerRegistry $doctrine, $id, EntityManagerInterface $em): Response
    {
        $product = $em->getRepository(Product::class)->find($id);
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            //kiểm tra xem người dùng có muốn upload ảnh mới hay không
            $imageFile = $form['imgurl']->getData();
            if ($imageFile != null) {
                $file = $form->get('imgurl')->getData();
                $imgName = uniqid();
                $imgExtension = $file->guessExtension();
                $imageName = $imgName . "." . $imgExtension;
                try {
                    $file->move(
                        $this->getParameter('product_imgurl'),
                        $imageName
                    );
                } catch (FileException $e) {
                    throwException($e);
                }
                $product->setImgurl($imageName);
            }
            //gọi đến Manager (Doctrine) để add object (row in table)
            $entityManager = $doctrine->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('Info', 'Update product successfully !');
            return $this->redirectToRoute('crud_product_index');
        }

        return $this->render('crud_product/update.html.twig', [
            'form' => $form->createView(),
        ]);
    }
    #[Route('/crud/delete/{id}', name: 'crud_product_delete')]
    public function delete(Request $request, ManagerRegistry $doctrine, $id, EntityManagerInterface $em): Response
    {
        $product = $em->getRepository(Product::class)->find($id);
        $entityManager = $doctrine->getManager();
        $entityManager->remove($product, true);
        $entityManager->flush();
        $this->addFlash('Info', 'Delete product successfully !');

        return $this->redirectToRoute(
            'crud_product_index'
        );
    }

    /**
     * @Route("/addCart/{id}", name="add_cart", methods={"GET"})
     */
    public function addCart(Product $product, Request $request)
    {
        $session = $request->getSession();
        $quantity = (int)$request->query->get('quantity');

        //Kiểm tra giỏ hàng có trống hay không
        if (!$session->has('cart')) {
            //Nếu giỏ hàng trống tạo một array(product id và quantity)
            $cart = array($product->getID() => $quantity);
            //Lưu lại sản phẩm đầu tiên vừa mới tạo array ở trên vào session
            $session->set('cart', $cart);
        } else {
            $cart = $session->get('cart');
            //Thêm một product vào cart sau lần thêm đầu tiên
            $cart = array($product->getID() => $quantity) + $cart;
            //Lưu lại product đã thêm vào session
            $session->set('cart', $cart);
        }
        return $this->redirectToRoute('product_show', ['id' => $product->getId()]);
    }

    /**
     * @Route("/viewCart", name="view_cart", methods={"GET"})
     */
    public function viewCart(Request $request, ProductRepository $productRepository)
    {
        $total = 0;
        $session = $request->getSession();
        $cart = $session->get('cart', []);
        $cartWithData = [];
        foreach ($cart as $id => $quantity) {
            $cartWithData[] = [
                'product' => $productRepository->find($id),
                'quantity' => $quantity
            ];
        }
        foreach ($cartWithData as $item) {
            $totalItem = $item['product']->getPrice() * $item['quantity'];
            $total += $totalItem;
        }
        return $this->render('cart/cart.html.twig', [
            'items' => $cartWithData,
            'total' => $total
        ]);
    }

    /**
     * @Route("/deleteCart/{id}", name="delete_cart", methods={"POST"})
     */
    public function deleteCart(Request $request, Product $product, ManagerRegistry $managerRegistry, ProductRepository $productRepository, $id)
    {
        $session = $request->getSession();

        $cart = $session->get('cart');

        unset($cart[$id]);
        $session->set('cart', $cart);

        return $this->redirectToRoute(
            'view_cart'
        );
    }
    /**
     * @Route("/checkoutCart", name="checkout_cart", methods={"GET"})
     */
    public function checkoutCart(
        Request $request,
        ProductRepository $productRepository,
        ManagerRegistry $mr
    ): Response {
        $entityManager = $mr->getManager();

        $session = $request->getSession(); //get a session
        // check if session has elements in cart
        if (!$session->has('cart') && empty($session->get('cart'))) {
            return new Response("Shopping Cart has no product, please add some!");
        }

        try {
            $order = new Order();
            $order->setPurchaseDate(new \DateTime());
            /** @var \App\Entity\User $user */
            $user = $this->getUser();

            $order->setUser($user);

            $cartItems = $session->get('cart');
            $total = 0;

            foreach ($cartItems as $productId => $quantity) {
                $product = $productRepository->find($productId);

                $total += $product->getPrice() * $quantity;

                $oderDetail = new OrderDetail();
                $oderDetail->setProduct($product);
                $oderDetail->setQuantity($quantity);
                $entityManager->persist($oderDetail);

                $order->addOrderDetail($oderDetail);
            }
            $order->setTotal($total);
            $entityManager->persist($order);

            $entityManager->flush();

            $this->addFlash('Info','Order successfully !');
            // Clean up/Empty the cart data (in session) after all.
            $session->remove('cart');

            return $this->redirectToRoute('product_index', [], Response::HTTP_SEE_OTHER);
        } catch (Exception $e) {
            throw $e;
        }
    }
}
