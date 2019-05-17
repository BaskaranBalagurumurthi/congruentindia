<?php

namespace Drupal\droogle\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RequestStack;

/**
 * * Class DefaultController.
 * */
class DefaultController extends ControllerBase {

	 /**
	  *   * Symfony\Component\HttpFoundation\RequestStack definition.
	  *     *
	  *       * @var \Symfony\Component\HttpFoundation\RequestStack
	  *         */
	 protected $requestStack;

	  /**
	   *   * The logger factory.
	   *     *
	   *       * @var \Drupal\Core\Logger\LoggerChannelFactoryInterface
	   *         */
	  protected $loggerFactory;

	  /**
	   *   * Constructs a new DefaultController object.
	   *     */
	  public function __construct(RequestStack $request_stack, LoggerChannelFactoryInterface $loggerFactory) {
		     $this->requestStack = $request_stack;
		        $this->loggerFactory = $loggerFactory;
		      }

	   /**
	    *   * {@inheritdoc}
	    *     */
	   public static function create(ContainerInterface $container) {
		      return new static(
			           $container->get('request_stack'),
				        $container->get('logger.factory')
					   );
		       }

	   /**
	    *   * Handlerequest.
	    *     *
	    *       * @return mixed
	    *         *   Return Hello string.
	    *           */
	   public function handleRequest() {
		      $this->loggerFactory->get('droogle')->info('droogle triggered');
		      $this->processRequest();
		      $data = [
				      	'speech' => 'Cache Rebuild Completed for the Site',
				        'displayText' => 'Cache Rebuild Completed',
					'data' => '',
					'contextOut' => [],
			];
			    return JsonResponse::create($data, 200);
		}

	   protected function processRequest() {

		   $params = $this->requestStack->getCurrentRequest();

		      // Here we will process the request to get intent
		      //
		      // and fulfill the action.
	        }
	}
