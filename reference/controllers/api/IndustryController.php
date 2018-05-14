<?php

use App\Models\Api\Industry as Industry;

class IndustryController extends ApiController
{
    protected $model = 'App\Models\Api\Industry';


    public function getIndustry($date, $fund = null)
    {
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

        try {
            $args = $this->makeFindArgs($findArgs);
            unset($args['hydration']);

            $industrys = Industry::find($args);

            $industrys->rewind();
            $rows = array();

            while ($industrys->valid()) {
                $industry = $industrys->current();

                $row = $industry->toArray();
                $row['security_type'] = $this->getSecurityType($row);
                $rows[] = $row;

                $industrys->next();
            }
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
        echo json_encode($rows);
    }

    public function getIndustryCsv($date, $fund = null)
    {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        $date = $this->getCurrent($this->model, $date, $fund);

        if ($fund) $findArgs = array(
            'run_date' => $this->formatDate($date),
            'composite_ticker' => $fund
        );
        else $findArgs = array(
            'run_date' => $this->formatDate($date)
        );

        $fd_out = fopen("php://output", 'w');

        try {
            $args = $this->makeFindArgs($findArgs);
            unset($args['hydration']);

            $industrys = Industry::find($args);

            $industrys->rewind();

            while ($industrys->valid()) {
                $industry = $industrys->current();

                $row = $industry->toArray();
                $row['security_type'] = $this->getSecurityType($row);
                fputcsv($fd_out, $row);

                $industrys->next();
            }
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
        fclose($fd_out);

    }

    protected function getSecurityType($row)
    {
        if ($row['is_etn']) return 'ETN';
        if ($row['asset_class'] == 'Currency' || $row['asset_class'] == 'Commodity') return "ETC";
        return "ETF";
    }

    public function getIndustryOrig($date, $fund = null)
    {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        if (Customer::hasPermission($this->request->getServer('PHP_AUTH_USER'), 'api', 'industry') !== true) {
            return $this->returnError(401, "Unauthorized", $response);
        }

        if ($fund) $findArgs = array(
            'run_date' => $this->formatDate($date),
            'composite_ticker' => $fund
        );
        else $findArgs = array(
            'run_date' => $this->formatDate($date)
        );

        return $this->returnResponse($this->model, $response, $findArgs);
    }


    public function getIndustryExposures($type, $date, $fund) {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();

        if (Customer::hasPermission($this->request->getServer('PHP_AUTH_USER'), 'api', 'industry') !== true) {
            return $this->returnError(401, "Unauthorized", $response);
        }

        $date = $this->getCurrent($this->model, $date, $fund);

        $findArgs = array(
            'run_date' => $this->formatDate($date),
            'composite_ticker' => $fund
        );

        $args = $this->makeFindArgs($findArgs);
        unset($args['hydration']);

        $industry = Industry::findFirst($args);

        switch ($type) {
            case 'geographic':
            case 'currency':
            case 'sector':
            case 'industry_group':
            case 'industry':
            case 'subindustry':
            case 'coupon':
            case 'maturity':
                $exposure_attr = "{$type}_exposure";
                break;
            default:
                return $this->returnError(400, "Bad request", $response);
        }
        $exposures_raw = explode(';',$industry->$exposure_attr);
        foreach ($exposures_raw as $exposure) {
            list($key, $value) = explode('=', $exposure);
            $exposures[$key] = $value;
        }
        $x = arsort($exposures);

        $namevalues = array();
        foreach ($exposures as $name => $value) {
            $namevalues[] = array(
                'name' => $name,
                'weight' => $value
            );
        }
        $response->setStatusCode(200, "OK")->sendHeaders();
        $response->setContentType('application/json', 'UTF-8');
        $response->setContent(json_encode($namevalues));
        return $response;

    }
}