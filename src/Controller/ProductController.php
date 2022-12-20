<?php

namespace App\Controller;

use App\Entity\Product;
use App\Entity\Order;
use App\Entity\OrderDetail;
use App\Form\ProductType;
use App\Repository\OrderRepository;
use App\Repository\OrderDetailRepository;
use App\Repository\CategoryRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Psr\Log\LoggerInterface;
use Doctrine\ORM\EntityManagerInterface;

/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    #[Route('/', name: 'product_index')]
    public function viewtestw(ProductRepository $productRepository, Request $request)
    {
        $searchValue = $request->get('searchValue') ? $request->get('searchValue') :'';
        $products = $productRepository->searchProducts($searchValue);
        return $this->render('product/index.html.twig', 
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
            $this ->addFlash('Error', 'Product not found');
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
        $product= $em->getRepository(Product::class)->findAll();
        return $this->render('crud_product/index.html.twig', [
            'list' => $product,
        ]);
    }

    #[Route('/crud/create', name: 'crud_product_create')]
    public function create(Request $request, ManagerRegistry $doctrine):Response
    {
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            //gọi đến Manager (Doctrine) để add object (row in table)
            $entityManager = $doctrine->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('Info', 'Add book successfully !');
            return $this->redirectToRoute('crud_product_index');
        }
         
        return $this->render('crud_product/create.html.twig', [
            'form' => $form -> createView(),
        ]);
    }

    #[Route('/crud/update/{id}', name: 'crud_product_update')]
    public function update(Request $request, ManagerRegistry $doctrine,$id, EntityManagerInterface $em):Response
    {   
        $product= $em->getRepository(Product::class)->find($id);
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            //gọi đến Manager (Doctrine) để add object (row in table)
            $entityManager = $doctrine->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('Info', 'Update book successfully !');
            return $this->redirectToRoute('crud_product_index');
        }
         
        return $this->render('crud_product/update.html.twig', [
            'form' => $form -> createView(),
        ]);
    }
    #[Route('/crud/delete/{id}', name: 'crud_product_delete')]
    public function delete(Request $request, ManagerRegistry $doctrine,$id, EntityManagerInterface $em):Response
    {   
        $product= $em->getRepository(Product::class)->find($id);
        $entityManager = $doctrine->getManager();
        $entityManager->remove($product,true);
        $entityManager->flush();
        $this->addFlash('Info', 'Delete book successfully !');
         
        return $this->redirectToRoute('crud_product_index' 
        );
    }
    
}