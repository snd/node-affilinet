#!/usr/bin/env php
<?php

define ("WSDL_LOGON", "https://api.affili.net/V2.0/Logon.svc?wsdl");
define ("WSDL_STATS",  "https://api.affili.net/V2.0/PublisherProgram.svc?wsdl");


$Username = $argv[1]; // the publisher ID
$Password = $argv[2]; // the publisher web services password

$SOAP_LOGON = new SoapClient(WSDL_LOGON);
$Token = $SOAP_LOGON->Logon(array(
    'Username'  => $Username,
    'Password'  => $Password,
    'WebServiceType' => 'Publisher'
));

$params = array(
    'Query' => ''
);

$SOAP_REQUEST = new SoapClient(WSDL_STATS);
$req = $SOAP_REQUEST->GetMyPrograms(array(
    'CredentialToken' => $Token,
    'GetProgramsRequestMessage' => $params
));

echo json_encode($req);
