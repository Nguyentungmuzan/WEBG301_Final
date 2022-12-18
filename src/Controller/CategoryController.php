<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Category;
use Symfony\Component\HttpFoundation\Response;

class CategoryController extends AbstractController
{
    #[Route('/category', name: 'app_category')]
    public function index(): Response
    {
        return $this->render('category/index.html.twig', [
            'controller_name' => 'CategoryController',
        ]);
    }
    /**
     * @Route("/category/view/{id}", name = "view_category")
     */
    public function viewCategory ($id) {
        $category = $this->getDoctrine()->getRepository(Category::class)->find($id);
        if ($category != null) {
            return $this->render("category/detail.html.twig",
            [
                'category' => $category
            ]
            );
        } else {
            return $this->redirectToRoute("view_all_category");
        }     
    }

    /**
     */
    public function __construct() {
    }
}
