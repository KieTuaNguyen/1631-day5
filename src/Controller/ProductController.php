<?php

namespace App\Controller;

use App\Entity\Product;
use App\Form\ProductType;
use App\Repository\CategoryRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;


/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    /**
     * @Route("/listing/{pageId}", name="app_product_index", methods={"GET"})
     */
    public function index(
        ProductRepository $productRepository,
        Request $request,
        CategoryRepository $categoryRepository,
        int $pageId = 1
    ): Response {
        $minPrice = $request->query->get('minPrice');
        $maxPrice = $request->query->get('maxPrice');
        $cat = $request->query->get('category');
        $selectedCat = $categoryRepository->findAll($cat);
        // $product = $productRepository->findAll();
        // // $this->denyAccessUnlessGranted('ROLE_USER');
        // $hasAccess = $this->isGranted('ROLE_USER');
        // $tempQuery = $productRepository->findMore($minPrice, $maxPrice, $cat);
        // $pageSize = 3;
        // $paginator = new Paginator($tempQuery);
        // // you can get total items
        // $totalItems = count($paginator);
        // // get total pages
        // $numOfPages = ceil($totalItems / $pageSize);
        // if ($hasAccess) {
        //     return $this->render('product/index.html.twig', [
        //         'products' => $productRepository->findAll(),
        //         'selectedCat' => $selectedCat,
        //         'categories' => $categoryRepository->findAll(),
        //         'numOfPages' => $numOfPages,
        //         'totalItems' => $totalItems,
        //     ]);
        // } else {
        //     return $this->render('product/index.html.twig', [
        //         'products' => [],
        //         'categories' => $categoryRepository->findAll(),
        //         'selectedCat' => $selectedCat,
        //         'categories' => $categoryRepository->findAll(),
        //         'numOfPages' => $numOfPages,
        //         'totalItems' => $totalItems,
        //     ]);
        // }

        if ($minPrice || $maxPrice) {
            $product = $productRepository->findMore($minPrice, $maxPrice, $cat);
        } else $product = $productRepository->findAll();
        if (!(is_null($cat)) || empty($cat)) {
            $selectedCat = $cat;
        } else {
            $selectedCat = "";
        }
        $tempQuery = $productRepository->findMore($minPrice, $maxPrice, $cat);
        $pageSize = 3;

        // load doctrine Paginator
        $paginator = new Paginator($tempQuery);
        // you can get total items
        $totalItems = count($paginator);
        // get total pages
        $numOfPages = ceil($totalItems / $pageSize);
        // now get one page's items:
        $tempQuery = $paginator
            ->getQuery()
            ->setFirstResult($pageSize * ($pageId - 1)) // set the offset
            ->setMaxResults($pageSize); // set the limit 

        return $this->render('product/index.html.twig', [
            'products' => $tempQuery->getResult(),
            'selectedCat' => $selectedCat,
            'categories' => $categoryRepository->findAll(),
            'numOfPages' => $numOfPages,
            'totalItems' => $totalItems,
        ]);
    }

    /**
     * @Route("/new", name="app_product_new", methods={"GET", "POST"})
     */
    public function new(Request $request, ProductRepository $productRepository): Response
    {
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);
        $this->denyAccessUnlessGranted('ROLE_USER');
        $user = $this->getUser();
        $product->setOwner($user);

        if ($form->isSubmitted() && $form->isValid()) {
            $productImage = $form->get('Image')->getData();
            if ($productImage) {
                $originExt = pathinfo($productImage->getClientOriginalName(), PATHINFO_EXTENSION);
                $productRepository->add($product, true);
                $newFilename = $product->getId() . '.' . $originExt;

                try {
                    $productImage->move(
                        $this->getParameter('product_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                }
                $product->setImgurl($newFilename);
                $productRepository->add($product, true);
            }
            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('product/new.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/phepcong", name="app_product_plus", methods={"GET", "POST"})
     */
    public function plus(Request $request): Response
    {
        $firstNumber = $request->get('a');
        $secondNumber = $request->get('b');
        $name = $request->get('name');

        return new Response('<html><body>Tong: ' . ($firstNumber + $secondNumber) . 'Welcome  ' . $name . '</body></html>');
    }

    /**
     * @Route("/{id}", name="app_product_show", methods={"GET"})
     */
    public function show(
        Product $product,
        Request $request,
        CategoryRepository $categoryRepository
    ): Response {
        $cat = $request->query->get('category');
        $selectedCat = $categoryRepository->findAll($cat);
        return $this->render('product/show.html.twig', [
            'product' => $product,
            'selectedCat' => $selectedCat,
            'categories' => $categoryRepository->findAll(),
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_product_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Product $product, ProductRepository $productRepository): Response
    {
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);
        $user = $this->getUser();

        if ($user != $product->getOwner()) {
            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        }
        if ($form->isSubmitted() && $form->isValid()) {
            $productRepository->add($product, true);

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('product/edit.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_product_delete", methods={"POST"})
     */
    public function delete(Request $request, Product $product, ProductRepository $productRepository): Response
    {
        if ($this->isCsrfTokenValid('delete' . $product->getId(), $request->request->get('_token'))) {
            $productRepository->remove($product, true);
        }

        return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
    }
    // private function filterRequestQuery($minPrice, $maxPrice, $cat)
    // {
    //     return [
    //         is_numeric($minPrice) ? (float) $minPrice : NULL,
    //         is_numeric($maxPrice) ? (float) $maxPrice : NULL,
    //         is_numeric($cat) ? (float) $cat : NULL
    //     ];
    // }
}
