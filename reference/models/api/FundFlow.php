<?php

namespace App\Models\Api;

use \Phalcon\Mvc\Model as Model;


class FundFlow extends Model
{
    public function initialize()
    {
        $this->setSource("fundflows");
        $this->getModelsManager()->setModelSchema($this, 'api');
    }
}