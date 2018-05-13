<?php

namespace App\Models\Api;

use \Phalcon\Mvc\Model as Model;


class Analytics extends Model
{
    public function initialize()
    {
        $this->setSource("analytics");
        $this->getModelsManager()->setModelSchema($this, 'api');
    }

    # date, $ticker, $group, $function
    static public function getAggregate($function, $date, $ticker, $group) {

        $af = "select %s(reward_score) %s_reward_score,%s(risk_total_score) %s_risk_total_score,%s(quant_total_score) %s_quant_total_score from api.analytics where run_date = :run_date and composite_ticker in (select composite_ticker from api.industry where focus in (select focus from api.industry where composite_ticker = :ticker))";

        $di = \Phalcon\DI::getDefault(); 
        $c = $di["db"];
        
	if ($date == "current") {
		$result = $c->fetchOne(
			"select max(run_date) from api.analytics",
            		\Phalcon\Db::FETCH_NUM
		);
		$date = $result[0];
        }

	$sql = sprintf($af, $function, $function, $function, $function, $function, $function);

        return $c->fetchAll(
            $sql,
            \Phalcon\Db::FETCH_ASSOC,
            [
               "run_date" => $date,
               "ticker" => $ticker
            ]
        );
    }
}

//
