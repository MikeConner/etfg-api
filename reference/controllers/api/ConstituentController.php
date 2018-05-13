<?php

use App\Models\Api\Constituent as Constituent;

class ConstituentController extends ApiController
{
    protected $model = 'App\Models\Api\Constituent';

    public function getByCusip($date, $fund, $id = null)
    {
        return $this->findByIdentifier($date, $fund, $id, 'cusip');
    }

    public function getByIsin($date, $fund, $id = null)
    {
        return $this->findByIdentifier($date, $fund, $id, 'isin');
    }

    public function getBySedol($date, $fund, $id = null)
    {
        return $this->findByIdentifier($date, $fund, $id, 'sedol');
    }

    public function getByFigi($date, $fund, $id = null)
    {
        return $this->findByIdentifier($date, $fund, $id, 'figi');
    }

    private function findByIdentifier($date, $fund, $id, $idType)
    {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        if (Customer::hasPermission($this->request->getServer('PHP_AUTH_USER'), 'api', 'constituents') !== true) {
            return $this->returnError(401, "Unauthorized", $response);
        }

        $date = $this->getCurrent($this->model, $date, $fund);

	if ($date === null) {
            $response->setStatusCode(200, "OK")->sendHeaders();
            $response->setContentType('application/json', 'UTF-8');
            $response->setContent(json_encode(array()));
            return $response;
	}

        $findArgs = array(
            'run_date' => $this->formatDate($date),
            'composite_ticker' => $fund
        );
        if ($id) $findArgs[$idType] = $id;

        return $this->returnResponse($this->model, $response, $findArgs);
    }

    public function getTopConstituents($date, $fund) {
        $model = $this->model;

        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        if (Customer::hasPermission($this->request->getServer('PHP_AUTH_USER'), 'api', 'industry') !== true) {
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

        $args = $this->makeFindArgs($findArgs);
        $args['limit'] = 10;
        $args['order'] = 'weight desc';

        try {
            $response->setStatusCode(200, "OK")->sendHeaders();
            $response->setContentType('application/json', 'UTF-8');
            $response->setContent(json_encode($model::find($args)->toArray()));
        } catch (Exception $e) {
            $response->setStatusCode(500, "Server error")->sendHeaders();
            echo $e->getMessage() . '<br>';
            echo '<pre>API:<br>' . $e->getTraceAsString() . '</pre>';
        }

        return $response;
    }
}
