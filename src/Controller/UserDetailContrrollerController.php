<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class UserDetailContrrollerController extends AbstractController
{
    #[Route('/user/detail/contrroller', name: 'app_user_detail_contrroller')]
    public function index(): Response
    {
        return $this->render('user_detail_contrroller/index.html.twig', [
            'controller_name' => 'UserDetailContrrollerController',
        ]);
    }
}
