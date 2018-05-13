<?php
/**
 * Created by PhpStorm.
 * User: jwc
 * Date: 4/25/2017
 * Time: 11:36 AM
 */

namespace App\Models\Api;

use \Phalcon\Mvc\Model as Model;

class EtpData extends Model
{
    public function initialize()
    {
        $this->setSource("etp_data");
        $this->getModelsManager()->setModelSchema($this, 'public');
    }
}