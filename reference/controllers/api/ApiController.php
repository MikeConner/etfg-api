<?php

use Phalcon\Mvc\Model\Resultset;

abstract class ApiController extends ControllerBase
{

    protected function formatDate($date)
    {
        $s = strtotime($date);
        if ($s === false) throw new Exception("Invalid date");
        return date('Y-m-d', $s);
    }

    protected function makeFindArgs($findArgs)
    {
        $conditions = "";
        $bind = array();
        $i = 1;
        foreach ($findArgs as $key => $value) {
            if ($conditions) $conditions .= " AND ";
            $conditions .= "{$key} = ?{$i}";
            $bind[$i] = $value;
            $i++;
        }
        return array(
            'conditions' => $conditions,
            'bind' => $bind,
            'hydration' => Resultset::HYDRATE_ARRAYS
        );
    }

    protected function returnResponse($model, \Phalcon\Http\Response $response, $findArgs)
    {
        try {
            $response->setStatusCode(200, "OK")->sendHeaders();
            $response->setContentType('application/json', 'UTF-8');
            $response->setContent(json_encode($model::find($this->makeFindArgs($findArgs))->toArray()));
        } catch (Exception $e) {
            $response->setStatusCode(500, "Server error")->sendHeaders();
            echo $e->getMessage() . '<br>';
            echo '<pre>API:<br>' . $e->getTraceAsString() . '</pre>';
        }

        return $response;
    }

    protected function returnError($code, $message, \Phalcon\Http\Response $response) {
        $response->setStatusCode($code, $message)->sendHeaders();
        return $response;
    }

    protected function getCurrent($model, $date, $fund)
    {
        if ($date == 'current') {
            $parameters = array(
                'column' => 'run_date'
            );

            if ($fund) {
                $parameters = array_merge($parameters, array(
                    'conditions' => 'composite_ticker = ?1',
                    'bind' => array(
                        1 => $fund
                    )
                ));
            }
            $date = $model::maximum($parameters);
        }
        return $date;
    }
}
