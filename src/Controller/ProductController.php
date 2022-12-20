<?php

namespace App\Controller;

use App\Entity\Product;
use App\Form\ProductType;
use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\EntityManagerInterface;


/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    #[Route('/', name: 'product_index')]
    public function viewtestw(ProductRepository $productRepository)
    {
        $products = $productRepository->findAll();
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
            //bổ sung code upload ảnh
            //B1: lấy ra ảnh vừa upload
            $file = $form->get('imgurl')->getData();
            //B2: set tên mới cho ảnh => đảm bảo tên ảnh là duy nhất trong thư mục
            $imgName = uniqid(); //uniqid : tạo ra string duy nhất
            //B3: lấy ra đuôi (extension) của ảnh
            //Yêu cầu cần thay đổi code của entity Product
            $imgExtension = $file->guessExtension();
            //B4: hoàn thiện tên mới cho ảnh (giữ đuôi cũ và thay tên mới)
            $imageName = $imgName . "." . $imgExtension;
            //VD: greenwich.jpg 
            //B5: di chuyển ảnh về thư mục chỉ định trong project
            try {
                $file->move(
                    $this->getParameter('product_imgurl'),
                    $imageName
                    //di chuyển file ảnh upload về thư mục cùng với tên mới
                    //note: cầu hình parameter trong file services.yaml
                );
            } catch (FileException $e) {
                throwException($e);
            }
            //B6: set dữ liệu của image vào object book
            $product->setImgurl($imageName);
            //gọi đến Manager (Doctrine) để add object (row in table)
            $entityManager = $doctrine->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('Info', 'Add book successfully !');
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
            //nếu có thì thực hiện code upload ảnh
            //nếu không thì bỏ qua
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

            $this->addFlash('Info', 'Update book successfully !');
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
        $this->addFlash('Info', 'Delete book successfully !');

        return $this->redirectToRoute(
            'crud_product_index'
        );
    }

}