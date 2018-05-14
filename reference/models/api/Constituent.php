<?php

namespace App\Models\Api;

use \Phalcon\Mvc\Model as Model;


class Constituent extends Model
{
    public function initialize()
    {
        $this->setSource("constituents");
        $this->getModelsManager()->setModelSchema($this, 'api');
    }
}