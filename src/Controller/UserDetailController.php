<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use App\Entity\UserDetail;
use App\Repository\UserDetailRepository;
use Symfony\Component\Routing\Annotation\Route;

class UserDetailController extends AbstractController
{

    #[Route('/UserDetail/{id}', name: 'user_detail_index')]
    public function index($id, UserDetailRepository $userRepository): Response
    {
        $userDetail = $userRepository->find($id);
        return $this->render(
            'user_detail/index.html.twig',
            [
                'user' => $userDetail
            ]
        );
    }
}