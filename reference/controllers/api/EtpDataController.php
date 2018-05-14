<?php
/**
 * Created by PhpStorm.
 * User: jwc
 * Date: 4/25/2017
 * Time: 11:24 AM
 */

#namespace etfg\controllers\api;

use App\Models\Api\EtpData as EtpData;


class EtpDataController extends \ApiController
{
    protected $model = 'App\Models\Api\EtpData';

    public function getEtpData($date = null)
    {
        $response = new \Phalcon\Http\Response();
        $this->view->disable();
        $fd = fopen("php://output", 'w');

        if ($date !== null) {
            $date = date('Y-m-d', strtotime($date));
            $etp_data = EtpData::query()
                ->where('date = :date:')
                ->andWhere('shares_outstanding is not null')
                ->andWhere('nav is not null')
                ->bind(array('date' => $date))
                ->execute();

            header("Content-type: text/csv");
            header("Content-Disposition: attachment; filename=etp_date_$date.csv");
            header("Pragma: no-cache");
            header("Expires: 0");

            $x = $etp_data->rewind();
            while ($etp_data->valid()) {
                $x = $etp_data->current();
                fputcsv($fd, array($x->date, $x->ticker, $x->shares_outstanding, $x->nav));
                $x = $etp_data->next();
            }
        }
        fclose($fd);
    }
}