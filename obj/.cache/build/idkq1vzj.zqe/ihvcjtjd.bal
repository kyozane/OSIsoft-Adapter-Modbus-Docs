<!DOCTYPE html>
<!--[if IE]><![endif]-->
<html>
  
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Adapter diagnostics </title>
    <meta name="viewport" content="width=device-width">
    <meta name="title" content="Adapter diagnostics ">
    <meta name="generator" content="docfx 2.53.1.0">
    
    <link rel="shortcut icon" href="../../../../favicon.ico">
    <link rel="stylesheet" href="../../../../styles/docfx.vendor.css">
    <link rel="stylesheet" href="../../../../styles/docfx.css">
    <link rel="stylesheet" href="../../../../styles/main.css">
    <meta property="docfx:navrel" content="../../../../toc.html">
    <meta property="docfx:tocrel" content="../../../toc.html">
    
    <meta property="docfx:rel" content="../../../../">
    
  </head>
  <body data-spy="scroll" data-target="#affix" data-offset="120">
    <div id="wrapper">
      <header>
        
        <nav id="autocollapse" class="navbar navbar-inverse ng-scope" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="../../../../V1/index.html" width="46">
                <img id="logo" src="../../../../V1/main/V1/images/atlas_icon.png" height="46" width="46" alt="OSIsoft Edge System"> 
              </a>
            </div>
            <div class="collapse navbar-collapse" id="navbar">
              <form class="navbar-form navbar-right" role="search" id="search">
                <div class="form-group">
                  <input type="text" class="form-control" id="search-query" placeholder="Search" autocomplete="off">
                </div>
              </form>
            </div>
          </div>
        </nav>
        
        <div class="subnav navbar navbar-default">
          <div class="container hide-when-search" id="breadcrumb">
            <ul class="breadcrumb">
              <li></li>
            </ul>
          </div>
        </div>
      </header>
      <div class="container body-content">
        
        <div id="search-results">
          <div class="search-list"></div>
          <div class="sr-items">
            <p><i class="glyphicon glyphicon-refresh index-loading"></i></p>
          </div>
          <ul id="pagination"></ul>
        </div>
      </div>
      <div role="main" class="container body-content hide-when-search">
        
        <div class="sidenav hide-when-search">
          <a class="btn toc-toggle collapse" data-toggle="collapse" href="#sidetoggle" aria-expanded="false" aria-controls="sidetoggle">Show / Hide Table of Contents</a>
          <div class="sidetoggle collapse" id="sidetoggle">
            <div id="sidetoc"></div>
          </div>
        </div>
        <div class="article row grid-right">
          <div class="col-md-10">
            <article class="content wrap" id="_content" data-uid="AdapterDiagnosticsOld">
<h1 id="adapter-diagnostics" sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="5" sourceendlinenumber="5">Adapter diagnostics</h1>

<p sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="7" sourceendlinenumber="7">OSIsoft adapters produce diagnostic data which you can use to find more information about a particular adapter instance. This data lives alongside the health data and you can egress it using a Health Endpoint and setting EnableDiagnostics = true. </p>
<p sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="9" sourceendlinenumber="9">For configuration of health endpoints, see &lt;/Health/Health.md&gt;.</p>
<h2 id="af-hierarchy" sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="11" sourceendlinenumber="11">AF hierarchy</h2>
<p sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="13" sourceendlinenumber="13">When you use PI Web API as a health endpoint, an AF hierarchy is created containing both the diagnostics and health data and metadata. Currently, OSIsoft Cloud Services does not provide a way to store static metadata and only contains the dynamic streams. For more information or to see an example of this hierarchy, see &lt;/Health/Health.md&gt;.</p>
<h3 id="stream-count" sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="15" sourceendlinenumber="15">Stream count</h3>
<p sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="17" sourceendlinenumber="17">The stream count indicates the number of streams and associated types being produced and sent data for a particular adapter instance.</p>
<table sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="19" sourceendlinenumber="23">
<thead>
<tr>
<th>Type</th>
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>string</td>
<td>Timestamp</td>
<td>Timestamp of event</td>
</tr>
<tr>
<td>int</td>
<td>StreamCount</td>
<td>Overall number of streams created by the adapter instance</td>
</tr>
<tr>
<td>int</td>
<td>TypeCount</td>
<td>Overall number of types created by the adapter instance</td>
</tr>
</tbody>
</table>
<h3 id="io-rate" sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="25" sourceendlinenumber="25">IO rate</h3>
<p sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="27" sourceendlinenumber="27">The IO rate indicates the running average number of streams per second being produced by an adapter instance.</p>
<table sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="29" sourceendlinenumber="32">
<thead>
<tr>
<th>Type</th>
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>string</td>
<td>Timestamp</td>
<td>Timestamp of event</td>
</tr>
<tr>
<td>double</td>
<td>IORate</td>
<td>Average data rate (streams/second)</td>
</tr>
</tbody>
</table>
<h3 id="error-rate" sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="34" sourceendlinenumber="34">Error rate</h3>
<p sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="36" sourceendlinenumber="36">The error rate indicates the average number of errors per second occurring for a particular adapter instance.</p>
<table sourcefile="V1/main/V1/ARCHIVE/Adapter diagnostics_old.md" sourcestartlinenumber="38" sourceendlinenumber="41">
<thead>
<tr>
<th>Type</th>
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>string</td>
<td>Timestamp</td>
<td>Timestamp of event</td>
</tr>
<tr>
<td>double</td>
<td>ErrorRate</td>
<td>Average error rate (streams/second)</td>
</tr>
</tbody>
</table>
</article>
          </div>
          
          <div class="hidden-sm col-md-2" role="complementary">
            <div class="sideaffix">
              <div class="contribution">
                <ul class="nav">
                  <li>
                    <a href="https://github.com/osisoft/OSIsoft-Adapter/blob/master/V1/ARCHIVE/Adapter diagnostics_old.md/#L1" class="contribution-link">Improve this Doc</a>
                  </li>
                </ul>
              </div>
              <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix" id="affix">
              <!-- <p><a class="back-to-top" href="#top">Back to top</a><p> -->
              </nav>
            </div>
          </div>
        </div>
      </div>
      
      <footer>
        <div class="grad-bottom"></div>
        <div class="footer">
          <div class="container">
            <span class="pull-right">
              <a href="#top">Back to top</a>
            </span>
            
            <span>© 2020 - OSIsoft, LLC.</span>
          </div>
        </div>
      </footer>
    </div>
    
    <script type="text/javascript" src="../../../../styles/docfx.vendor.js"></script>
    <script type="text/javascript" src="../../../../styles/docfx.js"></script>
    <script type="text/javascript" src="../../../../styles/main.js"></script>
  </body>
</html>