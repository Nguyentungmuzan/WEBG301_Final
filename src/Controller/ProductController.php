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


/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    #[Route('/', name: 'product_index')]
    public function viewtestw(ProductRepository $productRepository)
    {
        $products = $productRepository->findAll();
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
    
}