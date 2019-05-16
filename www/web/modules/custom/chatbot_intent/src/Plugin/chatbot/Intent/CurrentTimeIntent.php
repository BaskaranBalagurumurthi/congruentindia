<?php

namespace Drupal\chatbot_intent\Plugin\Chatbot\Intent;

use Drupal\chatbot_api\Plugin\IntentPluginBase;

/**
 *  * Intent Plugin for CurrentTime Dialogflow.
 *   *
 *    * @Intent(
 *     * id = "CurrentTime",
 *      * label = @Translation("Get current time")
 *       * )
 *        */
class CurrentTimeIntent extends IntentPluginBase {

	 /**
	  *  * {@inheritdoc}
	  *   */
	 public function process() {
		  $speech = "It's ".date('h:i A'). " Now!";
		   $this->response->setIntentResponse($speech);
		   }

}
