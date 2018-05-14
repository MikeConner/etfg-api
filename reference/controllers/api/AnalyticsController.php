<?php

use App\Models\Api\Analytics as Analytics;

class AnalyticsController extends ApiController
{
    protected $model = 'App\Models\Api\Analytics';

    # /{function}/{date}/{fund}/{group}
    public function getAggregateFunction($function, $date, $ticker, $group) {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        switch ($function) {
           case "avg":
           case "min":
           case "max":
           break;
           default:
               $response->setStatusCode(404, 'Function not found')->sendHeaders();
               return $response;
           break;
        }

	$m = $this->model;
	$r = $m::getAggregate($function, $date, $ticker, $group);

        $response->setStatusCode(200, "OK")->sendHeaders();
        $response->setContentType('application/json', 'UTF-8');
        $response->setContent(json_encode($r[0]));
	return $response;
    }

    public function getAnalytics($date, $fund = null)
    {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        if (Customer::hasPermission($this->request->getServer('PHP_AUTH_USER'), 'api', 'analytics') !== true) {
            return $this->returnError(401, "Unauthorized", $response);
        }

        $date = $this->getCurrent($this->model, $date, $fund);

        if ($fund) $findArgs = array(
            'run_date' => $this->formatDate($date),
            'composite_ticker' => $fund
        );
        else $findArgs = array(
            'run_date' => $this->formatDate($date)
        );

        return $this->returnResponse($this->model, $response, $findArgs);
    }
}
