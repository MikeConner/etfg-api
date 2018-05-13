<?php

use App\Models\Api\FundFlow as FundFlow;

class FundFlowController extends ApiController
{
    protected $model = 'App\Models\Api\FundFlow';

    public function getFundFlow($date, $fund = null)
    {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        if (Customer::hasPermission($this->request->getServer('PHP_AUTH_USER'), 'api', 'fundflow') !== true) {
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