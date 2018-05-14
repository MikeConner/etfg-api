<?php

namespace App\Models\Api;

use \Phalcon\Mvc\Model as Model;
use \Phalcon\Mvc\Model\MetaData\Memory as MetaData;


class Industry extends Model
{
    public function initialize()
    {
        $this->setSource("industry");
        $this->getModelsManager()->setModelSchema($this, 'api');
    }
}