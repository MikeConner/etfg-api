<?php

error_reporting(E_ALL);

define('APP_PATH', realpath('../..'));

/**
 * @return \Phalcon\Mvc\Micro\Collection
 */
function makeConstituentCollection()
{
    $constituentCollection = new Phalcon\Mvc\Micro\Collection();
    $constituentCollection->setHandler('ConstituentController', true);
    $constituentCollection->setPrefix("/constituent");

    $constituentCollection->get('/cusip/{date}/{fund}/{id}', 'getByCusip');
    $constituentCollection->get('/cusip/{date}/{fund}', 'getByCusip');

    $constituentCollection->get('/isin/{date}/{fund}/{id}', 'getByIsin');
    $constituentCollection->get('/isin/{date}/{fund}', 'getByIsin');

    $constituentCollection->get('/sedol/{date}/{fund}/{id}', 'getBySedol');
    $constituentCollection->get('/sedol/{date}/{fund}', 'getBySedol');


    $constituentCollection->get('/figi/{date}/{fund}/{id}', 'getByFigi');
    $constituentCollection->get('/figi/{date}/{fund}', 'getByFigi');

    return $constituentCollection;
}

function makeEtpDataCollection()
{
    $etpdataCollection = new Phalcon\Mvc\Micro\Collection();
    $etpdataCollection->setHandler('EtpDataController', true);
    $etpdataCollection->setPrefix("/etpdata");

    $etpdataCollection->get('/{date}', 'getEtpData');
    $etpdataCollection->get('/', 'getEtpData');
    return $etpdataCollection;
}


function makeFundFlowCollection()
{
    $fundflowCollection = new Phalcon\Mvc\Micro\Collection();
    $fundflowCollection->setHandler('FundFlowController', true);
    $fundflowCollection->setPrefix("/fundflow");

    $fundflowCollection->get('/{date}/{fund}', 'getFundFlow');
    $fundflowCollection->get('/{date}', 'getFundFlow');
    return $fundflowCollection;
}

function makeAnalyticsCollection()
{
    $analyticsCollection = new Phalcon\Mvc\Micro\Collection();
    $analyticsCollection->setHandler('AnalyticsController', true);
    $analyticsCollection->setPrefix("/analytics");

    $analyticsCollection->get('/{function}/{date}/{fund}/{group}', 'getAggregateFunction');
    $analyticsCollection->get('/{date}/{fund}', 'getAnalytics');
    $analyticsCollection->get('/{date}', 'getAnalytics');
    return $analyticsCollection;
}

function makeIndustryCollection()
{
    $industryCollection = new Phalcon\Mvc\Micro\Collection();
    $industryCollection->setHandler('IndustryController', true);
    $industryCollection->setPrefix("/industry");


    $industryCollection->get('/csv/{date}/{fund}', 'getIndustryCsv');
    $industryCollection->get('/csv/{date}', 'getIndustryCsv');
    $industryCollection->get('/exposures/{type}/{date}/{fund}', 'getIndustryExposures');
    $industryCollection->get('/{date}/{fund}', 'getIndustry');
    $industryCollection->get('/{date}', 'getIndustry');
    return $industryCollection;
}

function makeTopConstituentCollection()
{
    $topConstituentCollection = new Phalcon\Mvc\Micro\Collection();
    $topConstituentCollection->setHandler('ConstituentController', true);
    $topConstituentCollection->setPrefix("/topconstituents");

    $topConstituentCollection->get('/weight/{date}/{fund}', 'getTopConstituents');
    return $topConstituentCollection;
}

try {
    $config = include APP_PATH . "/app/config/config.php";
    include APP_PATH . "/app/config/loader.php";
    include APP_PATH . "/app/config/services.php";

    $app = new Phalcon\Mvc\Micro($di);

    $topConstituentCollection = makeTopConstituentCollection();
    $constituentCollection = makeConstituentCollection();
    $fundflowCollection = makeFundFlowCollection();
    $etpdataCollection = makeEtpDataCollection();
    $analyticsCollection = makeAnalyticsCollection();
    $industryCollection = makeIndustryCollection();

    $app->mount($topConstituentCollection);
    $app->mount($constituentCollection);
    $app->mount($fundflowCollection);
    $app->mount($etpdataCollection);
    $app->mount($analyticsCollection);
    $app->mount($industryCollection);

} catch (Exception $e) {
    $app->response->setStatusCode(500, "Server error.")->sendHeaders();
    echo $e->getMessage() . '<br>';
    echo '<pre>API:<br>' . $e->getTraceAsString() . '</pre>';
}

$app->notFound(function () use ($app) {
    $app->response->setStatusCode(404, "Destination Unknown")->sendHeaders(); # TODO: Fix this.
});

try {
    $app->handle();
} catch (Exception $e) {
    $app->response->setStatusCode(500, "Server error")->sendHeaders();
    echo $e->getMessage() . '<br>';
    echo '<pre>API:<br>' . $e->getTraceAsString() . '</pre>';
}
