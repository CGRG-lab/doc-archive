---
weight: 20
author: "Tsung-Hsi, Wu"
title: "Library"
date: "2022-04-29"
linkTitle: "Library"
---

<!-- 
`cd` to the folder where there is `.jmd`, and 
```
using HypertextTools
cd("doc_library")
lazyhugo();
cp2content(raw"D:\GoogleDrive\Sites\CGRG\doc-archive\content\en\docs\magtip\doc_library")
``` -->




<!-- # Documentation -->
**⚠Warning:**
- Please don't assign undocumented name-value pair parameters to the functions. For example, `'CreateInfoOnly'` and `'InParforLoop'`, which are preserved for parallel computing, and you will never need to set them manually.

## Main Functions

There are roughly four stages in the MagTIP forecasting process: 

1. the calculation of statistical index
2. the calculation of anomaly index number according to 1.
3. the calculation of TIP and the Molchan score according to 2.
4. probability forecasts according to 2. and 3.

The four stages is wrapped by four functions with keyword options that we can customize the parameters related to model optimization and probability forecast. 
The four main functions are wrapper functions for routine training and forecasting process. As follow:


### Data Conversion
#### `conv_geomagdata`


<div class="markdown"><p>The original geomagnetic data  &#40;which are those in &quot;.csv&quot; format being something like &quot;2008010300.KM&quot; or &quot;20190307.LY&quot;&#41; should be converted to a standard format before any calculation.  <code>conv_geomagdata&#40;dir_originalfiles, dir_data&#41;</code> read original data in <code>dir_originalfiles</code> and save them in the standard format at the directory <code>dir_data</code>.</p>
<p><strong>Keyword Argument:</strong></p>
<ul>
<li><p>&#39;ContinueFromLast&#39;: Default is <code>false</code>. If <code>true</code>, it compares the names  of all old files in the <code>dir_originalfiles</code> and the new files in <code>dir_data</code> before conversion  to avoid files that are already being converted to be converted again.  This additional procedure may take several hours depending on the size of database;  a more efficient way for avoiding  repeated processing is to manually specify &#39;FilterByDatetime&#39;. See below.</p>
</li>
<li><p>&#39;FilterByDatetime&#39;: Only convert the files in the assigned time range&#40;s&#41;. It supports: </p>
<ul>
<li><p>A datetime. For example, when <code>&#39;FilterByDatetime&#39;, datetime&#40;2010,10,10&#41;</code>, only files  with time tag being or after 2010-Oct-10 will be converted.</p>
</li>
<li><p>N by 2 datetime array, for example, </p>
<pre><code>&#39;FilterByDatetime&#39;, &#91;datetime&#40;2009,12,10&#41;, datetime&#40;2010,10,10&#41;;...
                     datetime&#40;2013,12,10&#41;, datetime&#40;2017,10,10&#41;&#93;;</code></pre>
<p>, only the files in the two time ranges &#91;2009-Dec-10, 2010-Oct-10&#93; and &#91;2013-Dec-10, 2017-Oct-10&#93; will be converted; ohterwise, ignored.</p>
</li>
</ul>
</li>
<li><p>&#39;Test&#39;: It take only the assigned ratio &#40;0-1&#41; of data &#40;files&#41; in  the directory <code>dir_originalfiles</code>. The files are randomly chosen.  This option should only be applied when you want to test your code for  reducing the overall computing time. Default is 0 &#40;when the assigned value for &#39;Test&#39; is &#36;\leq 0&#36; or &#36;\geq 1&#36;, there is no reduction in the data list&#41;.</p>
</li>
</ul>
<p><strong>NOTICE:</strong></p>
<ul>
<li><p>Files in the original format must be uniquely named as &#39;20200101.HC&#39; or  &#39;2020010109.HC&#39; for example.</p>
</li>
<li><p>If not uniquely named, such as &#39;..\HC\20200101.txt&#39;, &#39;..\CS\20200101.txt&#39;,  the second one will be regarded as a duplicated file and be moved out to  an alternative folder &#40;<code>dir_alt</code>&#41;</p>
</li>
<li><p>every file should have its extension as the code of the corresponding station,  e.g. &#39;20200101.HC&#39; is correct; &#39;20200101.txt&#39; is not valid and an error will occur.</p>
</li>
</ul>
</div>




#### `conv_gemsdata`

<div class="markdown"><p><code>conv_gemsdata&#40;dir_gems, saveto, dir_catalog&#41;</code> read original GEMS&#39;s data &#40;e.g., &quot;2012<em>02</em>07<em>16</em>45<em>00.dat&quot;&#41; in &#96;dir</em>gems&#96;, merge and convert them to the standard format for MagTIP.</p>
<p>Also see <code>&quot;read_gemsdata.m&quot;</code>. <strong>Example</strong>:</p>
<pre><code class="language-matlab">dir_gems &#61; &#39;g:\GEMSdat\&#39;;
&#37; where the individual data locates in for example:
&#37; &#39;g:\GEMSdat\em10\REC\Y2012\M02\D07\2012_02_07_16_45_00.dat&#39;
saveto &#61; &#39;d:\Data&#39;;
dir_catalog &#61; &#37; for obtaining the station information &#40;&quot;station_location.mat&quot;&#41;;
conv_gemsdata&#40;dir_gems, saveto, dir_catalog&#41;;</code></pre>
</div>



### Data Preprocessing


<div class="markdown"><p><code>M_prp &#61; no&#40;fpath&#41;</code> does no preprocessing, loads and returns the data of <code>fpath</code> in the form of matrix.</p>
<p>Other functions might also depends on <code>no</code>. For example, <code>prpfunctions</code> is dependent on <code>no</code> to get the directory of all functions for preprocessing. </p>
</div>



### Statistical Index Calculation (`statind`)

<div class="markdown"><p><code>statind&#40;dir_data,dir_output&#41;</code> calculate daily statistics &#40;a statistical  quantity as an index of the day&#41; of the daily timeseries in <code>dir_data</code>.  The output variables are stored in <code>dir_output</code>.</p>
<p><strong>Example</strong>:</p>
<pre><code class="language-matlab">statind&#40;dir_data,dir_output,&#39;StatName&#39;,&#39;S&#39;,&#39;StatFunction&#39;,@skewness, &#39;Preprocess&#39;, &#123;&#39;ULF_A&#39;,&#39;ULF_B&#39;&#125;&#41;;</code></pre>
<p>In which, <code>dir_data</code> is the directory for the time series in the standard format; <code>dir_output</code> is the <code>dir_stat</code> mentioned before.</p>
<p><strong>Keyword Arguments</strong>:</p>
<ul>
<li><p><code>&#39;StatName&#39;</code></p>
<ul>
<li><p>The abbreviations for the name of statistical indices.  They can be arbitrarily defined but have to be the same number of  elements as that of <code>&#39;StatFunction&#39;</code>.</p>
</li>
<li><p>Default is <code>&#123;&#39;S&#39;,&#39;K&#39;&#125;</code> &#40;for Skewness and Kurtosis&#41;.</p>
</li>
</ul>
</li>
<li><p><code>&#39;StatFunction&#39;</code></p>
<ul>
<li><p>The function handle for calculating statistical index.</p>
</li>
<li><p>It has to be of the same number of elements as that of <code>&#39;StatName&#39;</code></p>
</li>
<li><p>Default is <code>&#123;@skewness,@kurtosis&#125;</code> for calling the <code>skewness&#40;&#41;</code>  and <code>kurtosis&#40;&#41;</code> functions.</p>
</li>
</ul>
</li>
<li><p><code>&#39;Preprocess&#39;</code></p>
<ul>
<li><p>Apply filter&#40;s&#41; to time series loaded from <code>dir_data</code>. Generally  applying a filter very largely increase the computing time, so you  may consider <code>&#39;SavePreprocessedData&#39;</code>.</p>
</li>
<li><p>Default is <code>&#123;&#39;no&#39;&#125;</code>, where no filter will be applied.</p>
</li>
<li><p>Supported arguments are <code>&#39;no&#39;</code>, <code>&#39;ULF_A&#39;</code> &#40;a band pass filter of  frequency range <code>&#91;0.001 0.003&#93;</code> Hz&#41;, <code>&#39;ULF_B&#39;</code> &#40;<code>&#91;0.001 0.01&#93;</code> Hz&#41;,  and <code>&#39;ULF_C&#39;</code> &#40;<code>&#91;0.001 0.1&#93;</code> Hz&#41;.</p>
</li>
<li><p>Use <code>prpfunctions&#40;&#41;</code> to list all available preprocessing functions.</p>
</li>
<li><p>If multiple filters are applied, for example <code>&#123;&#39;no&#39;, &#39;ULF_A&#39;&#125;</code>, then  two sets of result according to no-filter data and ULF_A band passed data are going to be produced. </p>
</li>
</ul>
</li>
<li><p><code>&#39;SavePreprocessedData&#39;</code></p>
<ul>
<li><p>Save the preprocessed data to an alternative folder. Their directory is parallel to that of no-filter data.</p>
</li>
</ul>
</li>
<li><p><code>&#39;FilterByDatetime&#39;</code></p>
<ul>
<li><p>It should be a two element datetime array.</p>
</li>
<li><p>If applied, all files with date time tag not in the range will be ignored.</p>
</li>
<li><p>Default is <code>&#91;datetime&#40;0001,1,1&#41;, datetime&#40;2999,12,31&#41;&#93;</code>, resulting  in no data selection by date time tag.</p>
</li>
</ul>
</li>
</ul>
</div>


- The output directory and data structure is:
  ![](struct_stat.png)


<div class="markdown"><p><code>statind_parfor</code> is the parallel computing version of <code>statind</code>, it  takes the same input arguments and keyword options as <code>statind</code>.</p>
</div>



### Anomaly Index Number Calculation (`anomalyind`)

<div class="markdown"><p><code>anomalyind&#40;dir_stat,dir_output&#41;</code> calculates anomaly index number &#40;AIN&#41;  according to a list of &#36;A_\text&#123;thr&#125;&#36;; <code>dir_out</code> is where the output  variables stored. </p>
<p><strong>Example:</strong></p>
<pre><code>anomalyind&#40;dir_stat,dir_tsAIN&#41;;</code></pre>
<p><strong>Keyword Arguments</strong>:</p>
<ul>
<li><p><code>&#39;AthrList&#39;</code>:</p>
<ul>
<li><p>the list of &#36;A_\text&#123;thr&#125;&#36; &#40;the multiplier of the median value  of the statistical indices within the moving time window&#41;</p>
</li>
<li><p>default is <code>&#91;1:10&#93;</code></p>
</li>
</ul>
</li>
<li><p><code>&#39;MovingWindow&#39;</code></p>
<ul>
<li><p>the moving-window length for calculating the median value mentioned  above</p>
</li>
<li><p>default is <code>1000</code> &#40;days&#41;</p>
</li>
</ul>
</li>
</ul>
<p><strong>Input and output:</strong></p>
<ul>
<li><p><code>anomalyind</code> takes the statistic index output from <code>statind</code> by loading them from <code>dir_stat</code>.</p>
</li>
<li><p>The calculated anomaly index is saved in <code>dir_tsAIN</code>.</p>
</li>
</ul>
</div>



- The output directory and data structure is:
  ![](struct_tsAIN.png)


### TIP and Molchan Score Calculation (`molscore`)

<div class="markdown"><p><code>molscore&#40;dir_tsAIN,dir_catalog,dir_molchan&#41;</code> is responsible for single station&#39;s TIP &amp; Molchan score calculation. </p>
<p><strong>Example:</strong></p>
<pre><code>dir_catalog &#61; &#39;\MagTIP-2021\spreadsheet&#39;;
dir_tsAIN &#61; &#39;\MagTIP-2021\output_var\tsAIN-J13-TZ2&#39;;
dir_molchan &#61; &#39;\MagTIP-2021\output_var\MolchanScore-J13-TZ2&#39;;
molscore&#40;dir_tsAIN,dir_catalog,dir_molchan&#41;;</code></pre>
<p><strong>Keyword Arguments</strong>:</p>
<ul>
<li><p>&#39;TrainingPhase&#39;</p>
<ul>
<li><p>Assigns a &#40;set of&#41; training phase&#40;s&#41;. It should be of type <code>&#39;calendarDuration&#39;</code>, <code>&#39;duration&#39;</code>, an N by 2 array of <code>&#39;datetime&#39;</code>,  or an N by 2 cell array, where N is the number of the training phases. If given an N by 2 array specifying N training phases, then N sets  of results will be produced separately, with output format being  <code>&#39;&#91;MolScore&#93;stn&#91;&#37;x&#93;ID&#91;&#37;s&#93;prp&#91;&#37;s&#93;dt&#91;&#37;s-&#37;s&#93;.mat&#39;</code>.</p>
</li>
<li><p>For example, a 4 by 2 datetime array  <code>reshape&#40;datetime&#40;2009:2016,2,1&#41;,&#91;&#93;,2&#41;</code> specifies the start and end date of 4 training phases, with the first column being the datetime of the start and the second column being the end of each training phases.</p>
</li>
<li><p>For example, a 3 by 2 cell array </p>
<pre><code>&#123;calyears&#40;7&#41;,datetime&#40;2012,11,11&#41;;...
 calyears&#40;7&#41;,datetime&#40;2011,11,11&#41;;...
 calyears&#40;7&#41;,datetime&#40;2010,11,11&#41;&#125;;</code></pre>
<p>specifies the end day of the training phases as  2010-Nov-11, 2011-Nov-11 and 2012-Nov-11, all having a length of  7-year-long training period &#40;i.e. <code>calyears&#40;7&#41;</code>&#41;.  If the duration is negative &#40;e.g. <code>-calyears&#40;7&#41;</code>&#41;, the datetime of the  second column become the first day of each training phase.</p>
</li>
<li><p>Default is <code>calyears&#40;7&#41;</code>, which specifies the end day of training  phase the day before the last day of statistical indices or anomaly  index number, with a length of 7 year period.  That is, in default it &quot;trains&quot; and gives the best models according to the most recent 7-year data.</p>
</li>
</ul>
</li>
<li><p>&#39;modparam&#39;</p>
<ul>
<li><p>Specify the model parameters for grid search.  It should be a cell array; all elements in the cell array will be  directly passed into <code>modparam&#40;&#41;</code> as input arguments.</p>
</li>
<li><p>For example, &#123;<code>&#39;Athr&#39;,&#91;1:2:10&#93;,&#39;Rc&#39;,&#91;20, 30&#93;</code>&#125;.</p>
</li>
<li><p>Default is <code>&#123;&#125;</code>.</p>
</li>
</ul>
</li>
<li><p>&#39;AdditionalCheck&#39;</p>
<ul>
<li><p>Apply some additional check and tests. This option is for developer.</p>
</li>
<li><p>Default is <code>false</code>.</p>
</li>
</ul>
</li>
</ul>
<p><strong>Input and output:</strong></p>
<ul>
<li><p><code>molscore</code> takes anomaly indices from <code>dir_tsAIN</code> and earthquake catalog and station information from <code>dir_catalog</code>.</p>
</li>
<li><p>The output ranked models are saved in <code>dir_molchan</code>.</p>
</li>
</ul>
</div>


- The output directory and data structure is:
  ![](struct_molchan.png)


<div class="markdown"><p><code>molscore_parfor</code> is the parallel computing version of <code>molscore</code>, it  takes the same input arguments and keyword options as <code>molscore</code>.</p>
</div>



### Joint-station (3-D) TIP and Molchan Score Calculation (`molscore3`)

<div class="markdown"><p><code>molscore3</code> calculates the joint-station TIP, the Molchan score  between EQK and TIP, the Hit rate, and the earthquake probability. The calculation is based on optimized model given by <code>molscore</code>.</p>
<p><strong>Example:</strong></p>
<pre><code>dir_catalog &#61; &#39;\MagTIP-2021\spreadsheet&#39;;
dir_tsAIN &#61; &#39;\MagTIP-2021\output_var\tsAIN-J13-TZ2&#39;;
dir_molchan &#61; &#39;\MagTIP-2021\output_var\MolchanScore-J13-TZ2&#39;;
dir_jointstation &#61; &#39;\MagTIP-2021\output_var\JointStation-J13-TZ2&#39;;
molscore3&#40;dir_tsAIN,dir_molchan,dir_catalog,dir_jointstation&#41;</code></pre>
<p><strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;ForecastingPhase&#39;</p>
<ul>
<li><p>It can be a N by 2 datetime array with its size identical to the  training phases &#40;<code>trnphase</code>&#41;, specifying the time ranges of N  forecasting phases.</p>
</li>
<li><p>It can be &#39;calendarDuration&#39; or &#39;duration&#39;, saying <code>T</code>.  In this case, saying the last day of the training phase is  <code>trnphase&#40;i, end&#41;</code>, the forecasting phases are set to start from  <code>trnphase&#40;i, end&#41; &#43; 1</code>, and end at <code>trnphase&#40;i, end&#41; &#43; T</code>.</p>
</li>
<li><p>&#39;auto&#39;. In this case, forecasting phases are set to be as long as possible. That is, until the last day where tsAIN is available.</p>
</li>
<li><p>Default is one calendar year: <code>calyears&#40;1&#41;</code>.</p>
</li>
<li><p>Also see <code>formatForecastingPhase&#40;&#41;</code>.</p>
</li>
</ul>
</li>
<li><p>&#39;OverwriteFile&#39; </p>
<ul>
<li><p>Whether to overwrite existing output files or not.</p>
</li>
<li><p>Default is <code>true</code>.</p>
</li>
</ul>
</li>
<li><p>&#39;ModelSelect&#39;</p>
<ul>
<li><p>see <code>bestmodel&#40;&#41;</code></p>
</li>
</ul>
</li>
<li><p>&#39;ModelSelectOP&#39;</p>
<ul>
<li><p>see <code>bestmodel&#40;&#41;</code></p>
</li>
</ul>
</li>
<li><p>&#39;ChooseBest&#39;</p>
<ul>
<li><p>Define the number of maximum best models for each station to be applied. </p>
</li>
<li><p>Default is 10, which means we pick the models of top 10 fitting degrees each station for calculating predicted TIP&#40;s&#41;.</p>
</li>
</ul>
</li>
<li><p>&#39;CombinationNumber&#39;</p>
<ul>
<li><p>Define the total number of random combinations among the best models  of each station for joint-station TIP calculation. </p>
</li>
<li><p>Default is 500, which means for every station a random permutation of  ranking numbers &#40;based on the fitting degree&#41; of the best models is  performed with each sequence of ranking number having 500 elements,  and the ith joint-station model parameter combination is thus from the  best models of each station indexed by the ith element of each permutation.    </p>
</li>
</ul>
</li>
</ul>
<p><strong>Input and output:</strong></p>
<ul>
<li><p><code>molscore3</code> takes anomaly indices from <code>dir_tsAIN</code>, earthquake catalog and station information from <code>dir_catalog</code>, and ranked model form <code>dir_molchan</code>.</p>
</li>
<li><p>The output probability is saved in <code>dir_jointstation</code>.</p>
</li>
</ul>
</div>


- The output directory and data structure is:
  ![](struct_jointstation.png)
  

<div class="markdown"><p><code>molscore3_parfor</code> is the parallel computing version of <code>molscore3</code>, it  takes the same input arguments and keyword options as <code>molscore3</code>.</p>
</div>




## Format

<div class="markdown"><p><code>fmt</code> is a class that </p>
<ol>
<li><p>stores all constant names</p>
</li>
<li><p>stores all constant variables</p>
</li>
</ol>
<p>that enalbes you to modify or extend some contants without breaking other functionalities.</p>
<p><code>fmt</code> also serves as &quot;dictionaries&quot; of names to corresponding variables.</p>
<p><strong>Functions</strong>:</p>
<ul>
<li><p><code>colindex2data&#40;what_type&#41;</code>: returns column indices to time and data part of the loaded matrix. Example: <code>&#91;colind_time, colind_data&#93; &#61; colindex2data&#40;&#39;GEMS0&#39;&#41;</code></p>
</li>
<li><p><code>filterRange&#40;filter_tag&#41;</code>: returns two values indicating the lower and upper limit of the filter, in the unit of Hz. Example: <code>fmt.filterRange&#40;ULF_A&#41;</code>.</p>
</li>
<li><p><code>expecteddatapoint&#40;what_type&#41;</code>: returns the expected number of data point of a specific file type. Example: <code>totalpts &#61; expecteddatapoint&#40;&#39;GEMS0&#39;&#41;</code>; and you can derive sampling frequency <code>fs</code> by <code>fs &#61; totalpts/86400</code>.</p>
</li>
<li><p><code>fmtfieldname &#61; datatype_fieldname&#40;what_type&#41;</code>: returns the field name for <code>fmt</code> that you can <code>fmt.&#40;fmtfieldname&#41;</code>.</p>
</li>
</ul>
</div>




## Subfunctions
Subfunctions are those a user normally do not have a chance to use. However, if you are a developer, the information will be very helpful.


### Sum of Anomaly Indices (`convAIN`)

<div class="markdown"><p>Calculate the total amount of anomaly indices of each day.  That is, saying we have two statistical indices <code>S</code> and <code>K</code>, and the  total amount of anomaly indices is less or equal than 2. It is the &#39;update_tsAIN&#39; of the previous version.</p>
<p><strong>Example</strong>:</p>
<pre><code>&#91;sum_tsAIN, sum_validateIndex&#93; &#61; convAIN&#40;tsAIN.Athr, tsAIN.validateIndex&#41;</code></pre>
<p>For each Athr we have one anomaly index &#40;true or false&#41; and validation index &#40;true or false&#41; per day per variable,  and the output is the number of &quot;trues&quot; per day. Usually Athr &#61; 1:10, so the output will be a 10 by 1 cell in each there is a N by 1 double; N is the length of the DateTime series.</p>
<p><strong>Input arguments</strong>:</p>
<ul>
<li><p><code>tsAIN.Athr</code> or <code>tsAIN.validateIndex</code>:  A 1-by-10 structure array. See <code>anomalyind</code> for more information.</p>
</li>
</ul>
<p><strong>Output arguments</strong>:</p>
<ul>
<li><p><code>sum_tsAIN</code> or <code>sum_validateIndex</code>: A 10-by-1 cell array corresponding to &#36;A_&#123;thr&#125; &#61; 1:10&#36;.   In each cell, there is a N-by-1 double array being the sum of anomaly indices or the sum of valid indices of N days. </p>
</li>
</ul>
</div>



### Sum of Anomaly Days (`sumanomalyind`)

<div class="markdown"><p><code>&#91;DateTimeSAT,vlSAT&#93; &#61; sumanomalyind&#40;DateTime_j,sum_tsAIN_k,Nthr_array,Tobs_i&#41;</code> calculate sum of anomaly day &#40;<code>vlSAT</code>&#41; and its corresponding datetime  series &#40;<code>DateTimeSAT</code>&#41;. It is simply the moving-window sum of the <code>sum_tsAIN_k</code> timeseries, where the moving-window length is <code>Tobs_i</code>; in which, <code>i</code> stands for &#36;i_&#123;th&#125;&#36;  model, <code>j</code> for &#36;j_&#123;th&#125;&#36; station, and <code>k</code> for &#36;k_&#123;th&#125;&#36; threshold &#36;A_&#123;thr&#125;&#36;. Of coursely, the number of elements of the output timeseires &#40;<code>DateTimeSAT</code>&#41; will be <code>Tobs_i - 1</code> less than the input timeseries &#40;<code>DateTime_j</code> or <code>DateTime_dti</code>&#41;;  i.e., <code>length&#40;sum_tsAIN_k&#41; - length&#40;vlSAT&#41; &#61;  Tobs_i - 1</code>.</p>
<p><strong>Input arguments:</strong></p>
<ul>
<li><p><code>DateTime_j</code>: the datetime array for <code>sum_tsAIN</code>.</p>
</li>
<li><p><code>sum_tsAIN_k</code>: the sum of anomaly statistical indices each day.</p>
</li>
<li><p><code>Nthr_array</code>: The thresholds for <code>sum_tsAIN_k</code> calculated according to  <code>NthrRatio</code>. <code>Nthr</code> is known as the threshold of the total daily amount  of anomaly statistical indices.</p>
</li>
<li><p><code>Tobs_i</code>: the observation window of model i.</p>
</li>
</ul>
<p><strong>Output arguments:</strong></p>
<ul>
<li><p><code>DateTimeSAT</code>: M-by-1 datetime array for sum of anomaly days</p>
</li>
<li><p><code>vlSAT</code>: M-by-1 double array for the values of sum of anomaly days &#40;the anomaly days is summed in the moving window of <code>Tobs</code>&#41;</p>
</li>
</ul>
<p><strong>See also:</strong></p>
<ul>
<li><p><code>convAIN</code> for more details about <code>sum_tsAIN_k</code>.</p>
</li>
</ul>
</div>



### The Date Time at Which TIP is True (`dt_TIP_true`)

<div class="markdown"><p><code>&#91;dt_TIPtrue,TIPtime,TIP&#93; &#61; dt_TIP_true&#40;DateTimeSAT,vlSAT, Tthr,Tlead,Tpred&#41;</code> return the datetime where TIP is true.</p>
<p><strong>Input arguments:</strong></p>
<ul>
<li><p><code>DateTimeSAT</code>: M-by-1 datetime array for sum of anomaly days</p>
</li>
<li><p><code>vlSAT</code>: M-by-1 double array for the values of sum of anomaly days &#40;the anomaly days is summed in the moving window of <code>Tobs</code>&#41;</p>
</li>
<li><p><code>Tthr</code>: the threshold related to the number of anomaly days in <code>Tobs</code></p>
</li>
<li><p><code>Tlead</code>: the leading window right before the prediction window</p>
</li>
<li><p><code>Tpred</code>: the window of prediction &#40;where TIP is true or false according  to the number of anmalies in the corresponding Tobs window&#41;</p>
</li>
</ul>
<p><strong>Output arguments:</strong></p>
<ul>
<li><p><code>dt_TIPtrue</code>: the datetime where <code>TIP</code> is true</p>
</li>
<li><p><code>TIPtime</code>: an N-by-1 datetime array paired with the <code>TIP</code> array</p>
</li>
<li><p><code>TIP</code>: an N-by-1 logical array of Time of Increased Probability</p>
</li>
</ul>
<p>The variable <code>dt_TIPtrue</code> may exceeds the last day of <code>DateTimeSAT</code>,  while <code>TIPtime</code> is truncated to not exceed <code>DateTimeSAT&#40;end&#41;</code> in  <code>molscore</code>, because in training phase datetime out of <code>DateTimeSAT</code>  is assumed to be out of the time range of available earthquake catalog.</p>
<p><strong>A schematic illustration of the input/output variables:</strong></p>
<pre><code>sum_validateIndex_all_a_dti &#40;2nd input argument in sumanomalyind&#41;
               1100111011000001010010000000001010000000 &#40;for example&#41; 
DateTime_dti   tttttttttttttttttttttttttttttttttttttttt
Tobs length    |-----|  &#40;Tobs&#61;7, for example&#41; 
Tlead length          |-------| &#40;Tlead&#61;9, for example&#41; 
vlSAT                5445543222122233222221112122344332 &#40;for example&#41; 
DateTimeSAT index    123456789.........................         
DateTimeSAT    |Tobs |--------------------------------|         
TIPtime/TIP    |Tobs || Tlead ||--------------------------------------|
                               ↑                |Tobs || Tlead ||Tpred| 
                   Tpred start ↑        last AIN data ↑     Tpred end ↑    </code></pre>
</div>


### The Date Time at Which TIP is Valid (`dt_TIP_valid`)

<div class="markdown"><p><code>dt_TIP_valid</code> gives loosely valid TIP time and strictly invalid TIP time.  There are two possibilities for a TIP false: one is that the anomaly  index number &#40;AIN&#41; is below the threshold, and the other is that AIN is NaN since anything in comparison with a NaN results in a false.  The later we called it an &#39;invalid&#39; TIP time/day.</p>
<p><strong>Example:</strong></p>
<pre><code>&#91;TIPtime1,TIP_valid,dates_TIPvalid_st,dates_TIPinvalid_st&#93; &#61; ...
dt_TIP_valid&#40;DateTimeSAT,sum_validateIndex_all_a_dti,Tobs,Tlead,Tpred&#41;</code></pre>
<p>This  gives the datetime where there is at least one data in the <code>Tobs</code> and hence TIP false is a valid false.</p>
<p><strong>Input arguments:</strong></p>
<ul>
<li><p><code>DateTimeSAT</code>: see <code>sumanomalyind&#40;&#41;</code></p>
</li>
<li><p><code>sum_validateIndex_all_a_dti</code>: the <code>sum_validateIndex</code> in <code>convAIN&#40;&#41;</code></p>
</li>
<li><p><code>Tobs</code>: the observation time window right before the leading window &#40;<code>Tlead</code>&#41;. </p>
</li>
<li><p><code>Tlead</code>: the leading window right before the prediction window</p>
</li>
<li><p><code>Tpred</code>: the window of prediction &#40;where TIP is true or false according  to the number of anmalies in the corresponding Tobs window&#41;</p>
</li>
</ul>
<p><strong>Output arguments:</strong></p>
<ul>
<li><p><code>TIPtime1</code>: a 1-d datetime array for <code>TIP_valid</code></p>
</li>
<li><p><code>TIP_valid</code>: a 1-d logical array indicating whether the TIP is valid or not.     </p>
</li>
<li><p><code>dates_TIPvalid_st</code>:  Returns the datetimes of where the TIP have a meaningful <code>true</code>/<code>false</code>.</p>
</li>
<li><p><code>dates_TIPinvalid_st</code>:  Returns the datetimes of where the TIP have a meaningless <code>false</code>. &#40;If TIP is true, then the day should always be valid&#41;</p>
</li>
</ul>
<p>About the meaningful and meaningless &#39;false&#39;, see the comments in <code>anomalyind&#40;&#41;</code></p>
<p>Recalling that sum of AIN is  the sum of anomaly index calculated in the moving time window of length  Tobs, and the dates <code>DateTimeSAT&#40;sum_AIN_valid&#41;</code> denotes the end day of  Tobs where at least one of the anomaly index in the Tobs window is meaningful, we have the following example where Tlead &#61; 9, Tobs &#61; 7, and Tpred &#61; 3,  for explicitly demonstrates how the TIP&#39;s valid times are calculated:</p>
<pre><code>sum_validateIndex_all_a_dti
              &#39;1100111011000001010010000000001010000000&#39; &#40;for example&#41; 
DateTime_dti   tttttttttttttttttttttttttttttttttttttttt|
DateTimeSAT          tttttttttttttttttttttttttttttttttt|
sum_AIN_valid        1111111111111111111110001111111110|
dt_AIN_valid         ttttttttttttttttttttt   ttttttttt |
               |Tobs ||&lt;--a---&gt;|                       |&lt;--b-----&gt;|
TIPtime                        tttttttttttttttttttttttttttttttttttt
Tpred moving window            |c|                              |c|
                               | the same length as DateTimeSAT |
TIPvalid_0                     123456789........................
                                \\\\\\\
TIPvalid_1                       3456789..........................

Therefore, 
dt_TIPvalid &#61; unique&#40;TIPtime&#40;&#91;1:3,2:4,3:5,....&#93;&#41;&#41;

&#37; t denotes a datetime object
&#37; a &#61; Tlead&#43;1 &#61; idinc2predstart
&#37; b &#61; Tlead&#43;Tpred &#61; idinc2predend
&#37; c &#61; Tred
&#37; dt_AIN_valid is DateTimeSAT&#40;sum_AIN_valid&#41;, and sum_AIN_valid is a.k.a Tobs_TF.
&#37; TIPvalid_0 &#40;_1&#41; is a.k.a. TIP_TF_0 &#40;_1&#41;</code></pre>
</div>



### 1-d EQK and TIP (`eqktip1`)

<div class="markdown"><p><code>&#91;EQK,TIP, TIPtime&#93; &#61; eqktip1&#40;eqMR,eqDateTime, DateTimeSAT,vlSAT,                    Tthr_iMod,Tlead_iMod,Tpred_iMod, Mc_iMod,Rc_iMod&#41;</code> provides 1 dimensional logical array of target earthquakes &#40;<code>EQK</code>&#41; and  Time of Increased Probability &#40;<code>TIP</code>&#41;, corresponding to the 1-d datetime array <code>TIPtime</code>.</p>
<p><strong>Input arguments:</strong></p>
<ul>
<li><p><code>eqMR</code>: a N by 2 array of all-combination of model magnitudes and  radii of detection, with the first column being magnitude and second column the radius of detection.</p>
</li>
<li><p><code>eqDateTime</code>: a N by 1 cell array. Each cell contains the datetime of target earthquakes satisfying the corresponding row of <code>eqMR</code>; i.e.,  being larger than eqMR&#40;i,1&#41; and within eqMR&#40;i,2&#41;.</p>
</li>
<li><p><code>DateTimeSAT</code>, <code>vlSAT</code>: see <code>sumanomalyind</code>.</p>
</li>
<li><p><code>Tthr</code>, <code>Tlead</code>, <code>Tpred</code>: see <code>dt_TIP_true</code>.</p>
</li>
<li><p><code>Mc_iMod</code>: the current model magnitude.</p>
</li>
<li><p><code>Rc_iMod</code>: the current model radius of detection.</p>
</li>
</ul>
<p><strong>Output arguments:</strong></p>
<ul>
<li><p><code>EQK</code>: the M-by-1 logical array for whether there is/are target earthquakes in the day.</p>
</li>
<li><p><code>TIP</code>: an M-by-1 logical array of Time of Increased Probability</p>
</li>
<li><p><code>TIPtime</code>: an M-by-1 datetime array paired with the <code>TIP</code> and <code>EQK</code> array</p>
</li>
</ul>
<p><strong>See also:</strong></p>
<ul>
<li><p><code>&#91;~,eqMR,eqDateTime&#93; &#61; isearthquakeinrange&#40;...&#41;</code> in <code>molscore</code></p>
</li>
<li><p><code>&#91;DateTimeSAT,vlSAT&#93; &#61; sumanomalyind&#40;...&#41;</code> in <code>molscore</code></p>
</li>
</ul>
</div>



### Joint-station Probability (`jointstation`)

<div class="markdown"><p><code>jointstation</code> calculates hit rates, alarmed rates, and spatial probability.</p>
<p><strong>Example:</strong></p>
<p>When it is applied for calculating the hit rates of the training phase:</p>
<pre><code>HitRates_trn &#61; jointstation&#40;BestModels,BestModelNames,idPermute,...
             sum_tsAINs,sum_validateInds,DateTime_dti,...
             CWBcatalog,&#39;CalculateHitRate&#39;,true&#41;;</code></pre>
<p>When it is applied for calculating the forecasting probabilities:</p>
<pre><code>&#91;HitRates_frc, AlarmedRates_frc, SpatialProbability, xLon, yLat, ...
    validStationTime, ProbTime, TIP3, TIPvalid3, EQKs&#93;...
    &#61; jointstation&#40;BestModels,BestModelNames,idPermute,...
         sum_tsAINs,sum_validateInds,DateTime_dti,...
         CWBcatalog,&#39;CalculateHitRate&#39;,true,...
         &#39;CalculateAlarmedRate&#39;,true,&#39;CalculateProbability&#39;,HitRates_trn,...
         &#39;StationLocation&#39;,StationLocation&#41;;</code></pre>
<p><strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;CalculateHitRate&#39;: Whether to calculate the hit rates. Default is <code>false</code>.</p>
</li>
<li><p>&#39;CalculateAlarmedRate&#39;: Whether to calculate the alarmed rates. Default is <code>false</code>.</p>
<ul>
<li><p>If &#39;CalculateProbability&#39; is true, &#39;CalculateAlarmedRate&#39; will be automatically set to be true since alarmed rates are essential to probability calculation.</p>
</li>
</ul>
</li>
<li><p>&#39;CalculateProbability&#39;: Whether to calculate the spatial probability. Default is <code>false</code>.</p>
</li>
<li><p>&#39;StationLocation&#39;: </p>
<ul>
<li><p>A J by 3 table with the column names being &#39;format&#39;, &#39;Lon&#39;, &#39;Lat&#39; and row names &#40;i.e. <code>StationLocation.Properties.RowNames</code>&#41; the station codes &#40;e.g. &#39;TW&#39;, &#39;CS&#39;,...&#41; of the total J stations.</p>
</li>
<li><p>If &#39;CalculateAlarmedRate&#39; is true, &#39;StationLocation&#39; must be specified; otherwise it is impossible to obtain alarm rates.</p>
</li>
<li><p>Default is <code>0</code>.</p>
</li>
</ul>
</li>
</ul>
<p><strong>Input arguments:</strong></p>
<ul>
<li><p><code>BestModels</code>: A J-by-1 cell array containing the best models of total J stations. In each cell there is a table model parameters.</p>
</li>
<li><p><code>BestModelNames</code>: An J-by-1 cell array containing station names  corresponding to <code>BestModels</code> &#40;also J-by-1 cell array&#41;.</p>
</li>
<li><p><code>idPermute</code>: The randomly permuted indices for the best models. See <code>bestmodel&#40;&#41;</code>.</p>
</li>
<li><p><code>sum_tsAINs</code>: A J-by-1 cell array with each cell corresponding to  <code>BestmodelNames</code>. See <code>loadAIN&#40;&#41;</code>.</p>
</li>
<li><p><code>sum_validateInds</code>: A J-by-1 cell array with each cell corresponding to <code>BestmodelNames</code>. See <code>loadAIN&#40;&#41;</code>.</p>
</li>
<li><p><code>DateTime_dti</code>: A T by 1 datetime array for the time series in <code>sum_tsAINs</code>  and the <code>sum_validateInds</code>.</p>
</li>
<li><p><code>CWBcatalog</code>: A table of earthquake catalog. You may load <code>CWBcatalog</code>  using <code>only1field&#40;&#91;dir_catalog filesep &#39;catalog.mat&#39;&#93;&#41;</code>.</p>
</li>
</ul>
<p><strong>Output arguments:</strong></p>
<ul>
<li><p><code>HitRates</code>, <code>AlarmedRates</code>: M by 1 array, being the hit rates &#40;alarmed rates&#41;  of each combination of best models. M is the amounts of total  combinations &#40;the <code>totalM</code> in <code>bestmodel&#40;&#41;</code>&#41;. They are <code>AlarmedRateForecasting</code> and <code>HitRatesForecasting</code> of <code>molscore3</code>&#39;s output.</p>
</li>
<li><p><code>SpatialProbability</code>: A S by T array of the temporal-spatial forecasting probabilities. It is the output variable <code>Probability</code> of  <code>molscore3&#40;&#41;</code>. </p>
</li>
<li><p><code>xLon</code> &#40;<code>yLat</code>&#41;: The longitudes &#40;latitudes&#41; of all spatial points as a S by 1 array. It is the output variable <code>ProbabilityLon</code> &#40;<code>ProbabilityLat</code>&#41;  of <code>molscore3&#40;&#41;</code>.</p>
</li>
<li><p><code>validStationTime</code>: A T by J table of the ratio of valid models each day each station. This is for <code>plotProbability&#40;&#41;</code>, that the ratio will be demonstrated as gradient color in the marker of each station. If the ratio is zero, the marker on map will be hollow.  It is the output variable <code>validStationTime</code> of <code>molscore3&#40;&#41;</code>.</p>
</li>
<li><p><code>TIP3</code>: A S by T TIP array for the first model &#40;out of the total M models&#41;. Since the first element of each cell in <code>idPermute</code> is always 1,  indicating the best model, <code>TIP3</code> is essentially the TIP array calculated according to the best model parameter. </p>
</li>
<li><p><code>TIPvalid3</code>: A spatial-temporal logical array indicating whether a point &#40;s,t&#41; of TIP true or false is meaningful or not. This is also a S by T array. </p>
</li>
<li><p><code>ProbTime</code>: A 1 by T datetime array for <code>TIP3</code>, <code>TIPvalid3</code> and <code>SpatialProbability</code>. This is the <code>ProbabilityTime</code> of <code>molscore3</code>&#39;s output. </p>
</li>
<li><p><code>EQKs</code>: The list of target earthquake, with each column</p>
<ul>
<li><p><code>time</code>, <code>Lon</code>, <code>Lat</code>, <code>Depth</code>, <code>Mag</code>: The time, longitude, latitude, depth and magnitude &#40;&#36;M_L&#36;&#41; of the target earthquake.</p>
</li>
<li><p><code>InStation</code>: Indicates the target earthquake is of which station.</p>
</li>
<li><p><code>EqkDist</code>: The distance between the station &#40;as specified by <code>InStation</code>&#41;  and hypocenter of the target earthquake. Also see <code>simpleStationEQKdist3D</code>.</p>
</li>
</ul>
</li>
</ul>
</div>



### Anomaly Index Number of each day (`loadAIN`)

<div class="markdown"><pre><code>&#91;sum_tsAINs,sum_validateInds,DateTime_dti,AthrList&#93; &#61;
loadAIN&#40;dir_tsAIN,BestModelNames,TimeRange&#41;</code></pre>
<p>load tsAIN, calculate the summation of anomaly index of each day, and  truncate the time series to <code>TimeRange</code>. </p>
<p>If <code>class&#40;BestModelNames&#41; &#61;&#61; &#39;char&#39;</code>, for example, &#39;CS&#39;, the output  <code>sum_tsAINs</code> and <code>sum_validateInds</code> are the 10 by 1 cell array  directly, instead of a M by 1 cell array inside the J by 1 cell array where J &#61; 1.</p>
<p><strong>Input arguments:</strong>:</p>
<ul>
<li><p><code>dir_tsAIN</code>: the directory for the saved AIN data. See <code>anomalyind&#40;&#41;</code>.</p>
</li>
<li><p><code>BestModelNames</code>: an J-by-1 cell array containing station names  corresponding to <code>BestModels</code> &#40;also J-by-1 cell array&#41;.</p>
</li>
<li><p><code>TimeRange</code>: a two-element datetime array.</p>
</li>
</ul>
<p><strong>Output arguments:</strong>:</p>
<ul>
<li><p><code>sum_tsAINs</code>: a J-by-1 cell array with each cell corresponding to  <code>BestmodelNames</code>. In each cell there is a 10-by-1 cell corresponding to the list of &#36;A_&#123;thr&#125;&#36; &#40;<code>AthrList &#61; 1:10</code>&#41;, being the timeseries of  the summation of anomaly index of each day.</p>
</li>
<li><p><code>sum_validateInds</code>: a J-by-1 cell array with each cell corresponding to <code>BestmodelNames</code>. In each cell there is a 10-by-1 cell corresponding to the list of &#36;A_&#123;thr&#125;&#36; &#40;<code>AthrList &#61; 1:10</code>&#41;, being the summation of the  indicators for the valid statistical indices of each day.</p>
</li>
</ul>
</div>



### The Best Models (`bestmodel`)

<div class="markdown"><p><code>&#91;BestModels,BestModelNames,idPermute,molList&#93; &#61; bestmodel&#40;molList,BestN,totalM,StationLocation&#41;</code> filters the best N models out based on fitting degree and perform random permutation of total M combination of them.  That is, <code>bestmodel&#40;&#41;</code> save the best N &#40;at most&#41; models for each station in  <code>BestModels</code>, and gives an array of M elements that are randomly picked  from the set of the ranking numbers of the best N &#40;at most&#41; models. </p>
<p><strong>Input arguments</strong>:</p>
<ul>
<li><p><code>molList</code>: The list of paths to the files of ranked models, which are  produced by <code>molscore</code>. Get the <code>molList</code> using <code>datalist&#40;...&#41;</code>.</p>
</li>
<li><p><code>BestN</code>: The number the models of highest molchan score.</p>
</li>
<li><p><code>totalM</code>: The amount of randomly permuted combinations of the best N models. That is, M is the number of joint-station models. Noted that the first model combination is forced to be the combination of the best model of each station.</p>
</li>
<li><p><code>StationLocation</code>:   A J by 3 table with the column names being &#39;format&#39;,  &#39;Lon&#39;, &#39;Lat&#39; and row names &#40;i.e. <code>StationLocation.Properties.RowNames</code>&#41;  the station codes &#40;e.g. &#39;TW&#39;, &#39;CS&#39;,...&#41; of the total J stations.</p>
</li>
</ul>
<p><strong>Output arguments</strong>:</p>
<ul>
<li><p><code>BestModels</code>: A J-by-1 cell array containing the best models of total J stations. In each cell there is a table model parameters.</p>
</li>
<li><p><code>BestModelNames</code>: An J-by-1 cell array containing station names  corresponding to <code>BestModels</code> &#40;also J-by-1 cell array&#41;.</p>
</li>
<li><p><code>idPermute</code>: The randomly permuted indices for the best models.  It is a J by 1 cell array, where each cell contains a M by 1 double array being the indices for the Jth <code>BestModels</code>. Noted that the first element in the M by 1 double array is always <code>1</code>, which force the first model combination in <code>jointstation&#40;&#41;</code> to be the  combination of the best model of each station &#40;SEE <code>molscore3&#40;&#41;</code>&#41;.</p>
</li>
<li><p><code>molList</code>: The list of paths to the files of ranked models, where the files having all molchan scores to be NaN &#40;hence model parameters cannot  be ranked&#41; are excluded.</p>
</li>
</ul>
<p><strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;NearbyThreshold&#39;: For some reasons  &#40;e.g. no target earthquakes at all in the training phase&#41; models cannot be ranked &#40;optimized&#41; for a station &#40;saying &#39;MS&#39;&#41; because all molchan scores are NaN.  In this situation, <code>bestmodel</code> will try to find if there is a near-by station within 15 km &#40;in default&#41;.  If there is, for example, a station &#39;PT&#39; nearby within 15km of &#39;MS&#39;, then the ranked model &#39;PT&#39; will be taken instead.  That is, in the following process in <code>molscore3</code>, the best models of &#39;PT&#39; and the AIN based on the geomagnetic data of &#39;MS&#39; are applied  for calculating the probabilities around the station of &#39;MS&#39;.</p>
</li>
<li><p>&#39;ModelSelect&#39;: You may filter the table of Molchan scores by using this option. For example, with <code>&#39;ModelSelect&#39;, &#123;&#39;Tpred&#39;, 5&#125;</code>, all rows whose <code>Tpred</code> is not <code>5</code> will be discard. </p>
</li>
<li><p>&#39;ModelSelectOP&#39;</p>
<ul>
<li><p>The operator function for model selecting if <code>&#39;ModelSelect&#39;</code> have multiple pairs of input argument. </p>
</li>
<li><p>For example, with  <code>&#39;ModelSelect&#39;, &#123;&#39;Tpred&#39;, 5, &#39;Tlead&#39;, 5&#125;, &#39;ModelSelectOP&#39;, @or</code>,  all rows with <code>Tpred&#61;5</code> or <code>Tlead&#61;5</code> was kept; others, discarded. </p>
</li>
<li><p>Default is <code>@or</code>.</p>
</li>
</ul>
</li>
</ul>
</div>



### Station List Formatting (`checkstation`)

<div class="markdown"><p><code>&#91;isvalid, msg&#93; &#61; checkstation&#40;dir_catalog&#41;</code> check if <code>station_location.mat/csv</code>  exist in <code>dir_catalog</code>, and convert the <code>station_location.csv</code> to <code>station_location.mat</code>.  After successfully create <code>station_location.mat</code>, the original <code>station_location.csv</code> will be moved to the folder &#39;original_csv&#39;.</p>
<p>If the <code>station_location.csv</code> does not meet the required format, error will occur. The <code>station_location.csv</code> has to suffice the following condtions:</p>
<ul>
<li><p>The &#39;time&#39; variable should be in the following format: &#39;yyyy/MM/dd</p>
</li>
</ul>
<p>HH:mm&#39;.</p>
<ul>
<li><p>Other variables except &#39;time&#39; should belong the class of &#39;double&#39;.</p>
</li>
<li><p>Basicaly the following headers &#40;column names&#41;,</p>
</li>
</ul>
<p>&#123;&#39;code&#39;,&#39;format&#39;,&#39;Lon&#39;,&#39;Lat&#39;&#125; have to exist.  In which, </p>
<ul>
<li><p>&#39;code&#39; is the code for the station, whereas &#39;format&#39; is the full name of  the station. For example, &#39;MS&#39; &#40;code&#41; corresponds to &#39;馬仕&#39; &#40;format&#41;.</p>
</li>
<li><p>&#39;Lon&#39; and &#39;Lat&#39; are longitude and latitude of the station respectively.</p>
</li>
</ul>
<p>Aliases for the column names in the <code>station_location.csv</code> are allowed; see the <strong>Aliases</strong> section below.</p>
<p><strong>Aliases</strong>:  For convenience, aliases of the column name of an variable in <code>station_location.csv</code> will be automatically converted:</p>
<ul>
<li><p>For longitude and latitude, either &#123;&#39;lon&#39;, &#39;longitude&#39;, &#39;Longitude&#39;&#125;,</p>
</li>
</ul>
<p>&#123;&#39;lat&#39;, &#39;latitude&#39;, &#39;Latitude&#39;&#125; will be converted to &#39;Lon&#39; and &#39;Lat&#39;, respectively.</p>
</div>



### Earthquake Catalog Formatting (`checkcatalog`)

<div class="markdown"><p><code>&#91;isvalid, msg&#93; &#61; checkcatalog&#40;dir_catalog&#41;</code> check if <code>catalog.mat/csv</code>  exist in <code>dir_catalog</code>, and convert the <code>catalog.csv</code> to <code>catalog.mat</code>.  After successfully create <code>catalog.mat</code>, the original <code>catalog.csv</code> will be moved to the folder &#39;original_csv&#39;.</p>
<p>If the <code>catalog.csv</code> does not meet the required format, error will occur. The <code>catalog.csv</code> has to suffice the following condtions:</p>
<ul>
<li><p>The &#39;time&#39; variable should be in the following format: &#39;yyyy/MM/dd</p>
</li>
</ul>
<p>HH:mm&#39;.</p>
<ul>
<li><p>Other variables except &#39;time&#39; should belong the class of &#39;double&#39;.</p>
</li>
<li><p>Basicaly the following headers &#40;column names&#41;,</p>
</li>
</ul>
<p>&#123;&#39;time&#39;,&#39;Lon&#39;,&#39;Lat&#39;,&#39;Mag&#39;,&#39;Depth&#39;&#125;, have to exist. </p>
<p>Aliases for the column names in the <code>catalog.csv</code> are allowed; see the <strong>Aliases</strong> section below.</p>
<p><strong>Aliases</strong>:  For convenience, aliases of the column name of an variable in <code>catalog.csv</code> will be automatically converted:</p>
<ul>
<li><p>For earthquake magnitudes, the header of either &#123;&#39;Magnitude&#39;, &#39;magnitude&#39;, &#39;ML&#39;&#125; will be automatically converted to &#39;Mag&#39;.</p>
</li>
<li><p>For depths, the header of either &#123;&#39;depth&#39;, &#39;dep&#39;, &#39;Dep&#39;&#125; will be converted to &#39;Depth&#39;.</p>
</li>
<li><p>For longitude and latitude, either &#123;&#39;lon&#39;, &#39;longitude&#39;, &#39;Longitude&#39;&#125;,</p>
</li>
</ul>
<p>&#123;&#39;lat&#39;, &#39;latitude&#39;, &#39;Latitude&#39;&#125; will be converted to &#39;Lon&#39; and &#39;Lat&#39;, respectively.</p>
<p>For convenience, in <code>catalog.csv</code>, if the event time is written in separated two columns &#39;date&#39; and &#39;time&#39;,  with format &#39;yyyy-mm-dd&#39; &#40;or &#39;yyyy/mm/dd&#39;&#41; for &#39;date&#39; and &#39;hh:MM:ss&#39; &#40;or &#39;hh:MM&#39;&#41;, they will be merged  as a single &#39;time&#39; variable sufficing the format mentioned before.</p>
</div>



### Generate Model Parameters (`modparam`)

<div class="markdown"><p>In MagTIP, model parameters defines TIP and target earthquakes &#40;EQK&#41;.  <code>&#91;PredParam,varargout&#93;&#61;modparam&#40;&#41;</code> generate the whole set of model parameters  that are going to be used in the training phase by <code>molscore</code>. </p>
<p><strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;Rc&#39;: Radius &#40;range&#41; of detection in unit kilometer. Default is <code>&#91;20:10:100&#93;&#41;</code></p>
</li>
<li><p>&#39;NthrRatio&#39;: </p>
<ul>
<li><p>The ratio threshold to be converted to the number of anomalous statistic index every day. </p>
</li>
<li><p>&#39;NthrRatio&#39; should be calculated automatically in <code>molscore&#40;&#41;</code> according to the maximum possible number of statistic indices among the anomaly index calculated by <code>anomalyind&#40;&#41;</code>.</p>
</li>
<li><p><code>Nthr</code> is the threshold &#40;integer&#41; for the number of anomalous statistic indices each day.</p>
</li>
<li><p>Default is <code>&#91;0.01, 0.99&#93;</code>, which is for the situation where the maximum possible <code>Nthr</code> is &#36;\leq 2&#36; &#40;i.e., to be &#91;0, 1&#93;&#41;. If you have the maximum possible <code>Nthr</code> to be &#36;\leq 3&#36; &#40;i.e, <code>Nthr &#61; &#91;0 1 2&#93;</code>&#41;,  &#39;NthrRatio&#39; should be assigned to be <code>&#91;0.01, 0.49, 0.99&#93;</code> for example. </p>
</li>
</ul>
</li>
<li><p>&#39;Ptthr&#39;: <code>Ptthr</code> defines <code>Tobs</code> through <code>Ptthr &#61; Tthr/Tobs</code>. Default is <code>&#91;0.1:0.1:0.5&#93;</code>.</p>
</li>
<li><p>&#39;Tobs&#39;: The length of observation moving window. Default is <code>&#91;5:5:100&#93;</code>;</p>
</li>
<li><p>&#39;Tpred&#39;: The length of prediction moving window.</p>
</li>
<li><p>&#39;Tlead&#39;: The length of leading window, the time gap that is for the period of  silent &#40;no-anomaly&#41; right before big earthquakes. </p>
<ul>
<li><p>Default is &#91;0:5:100&#93;. </p>
</li>
</ul>
</li>
<li><p>&#39;Mc&#39;: The magnitude threshold. Default is <code>5</code>, which means only events of &#36;M_L \geq 5&#36; will be considered as target earthquakes.</p>
</li>
<li><p>&#39;Test&#39;:</p>
<ul>
<li><p>If true or 1, then the PredParam is reduced to 1000 randomly picked models from the default combination.</p>
</li>
<li><p>If it is a positive integer N other than 1, the predParam is reduced to N randomly picked models.</p>
</li>
<li><p>Default is 0.</p>
</li>
</ul>
</li>
<li><p>&#39;Seed&#39;: the seed for the random selection while &#39;Test&#39; is enable. </p>
<ul>
<li><p>Seed must be a nonnegative integer seed less than 2^32.</p>
</li>
<li><p>If seed is less than zero, the random selection has its result different everytime.</p>
</li>
</ul>
</li>
</ul>
<p><strong>Output</strong>:</p>
<ul>
<li><p><code>PredParam</code>: The GEMSTIP/MagTIP models of total 8 free parameters: <code>G &#61; &#91;Mag,Rad,NthrRatio,Athr,Tthr,Tobs,Tpred,Tlead&#93;</code>. </p>
</li>
</ul>
<p><strong>Examples:</strong>     - <code>&#91;PredParam, columnNames&#93; &#61; modparam&#40;&#39;OutputFormat&#39;,&#39;double&#39;&#41;;</code>     - <code>&#91;PredParam_table&#93; &#61; modparam&#40;&#39;OutputFormat&#39;,&#39;table&#39;&#41;;</code></p>
</div>





## Tools

All Tools are not necessary for the MagTIP algorithm; they are invented, for example, to demonstrate the results in figure or for generating/selecting directories in a convenient way.

### Plotting
#### Overview of All Geomagnetic Data (`plot_dataoverview`)

<div class="markdown"><p><code>plot_dataoverview&#40;dir_stat, dir_catalog&#41;</code> plot an overview of all data. <strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;SaveFigureTo&#39;: the output path</p>
</li>
<li><p>&#39;BackgroundColor&#39;: Background color; default is white &#40;<code>&#91;1,1,1&#93;</code>&#41;</p>
</li>
<li><p>&#39;DatetimeTicks&#39;: The format of datetime ticks on the x-axis. </p>
<ul>
<li><p>Default is <code>&#123;&#39;yyyy-mm&#39;,6,&#39;Months&#39;&#125;</code>, which means tick labels are in the format of <code>yyyy-mm</code> and interspaced every 6 months.</p>
</li>
</ul>
</li>
</ul>
</div>



#### Probability Forecast Map (`plotProbability`)

<div class="markdown"><p><code>plotProbability&#40;dir_jointstation,dir_catalog,dir_out&#41;</code> plots two-dimensional probability forecasting maps; the results are saved as png files in <code>dir_output</code>.</p>
<p><strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;LongitudeLimit&#39;: The longitude limits of the displayed map. Default is <code>&#91;119 122.5&#93;</code>.</p>
</li>
<li><p>&#39;LatitudeLimit&#39;: The latitude limits of the displayed map. Default is <code>&#91;21.5 26&#93;</code>.</p>
</li>
<li><p>&#39;TimeRange&#39;: Manually assign time ranges or specific dates that must lay in the forecasting phase to plotting probability forecast. If not set, the probability forecast of every available dates will be plotted. The assigned datetime array must be either: </p>
<ol>
<li><p>An N by 2 datetime array specifying N ranges at one time.</p>
</li>
<li><p>An N by 1 datetime array specifying N days to be plot.</p>
</li>
</ol>
</li>
<li><p>&#39;PlotEpicenter&#39;: Whether to plot the epicenter&#40;s&#41; of the target earthquakes on the map.</p>
</li>
<li><p>&#39;Rigorous&#39;: Whether to drop &#40;ignore&#41; the probability forecasts that are not in the range of the forecasting phases. Default is true. Generally the leading  time window &#40;<code>Tlead</code>&#41; is different among models, and the probability can be calculated as far as the <code>Tlead</code> of at least one model covered.  However, for the dates out of the forecasting phase, only part of the models are applied thus the probability forecast is weaker.</p>
</li>
<li><p>&#39;TargetPattern&#39;: the pattern for filtering the files in <code>dir_jointstation</code>. Default is to look up all files that fits the pattern  &quot;&#91;JointStation&#93;<em>.mat&quot;. For example, you can manually specify it as &quot;</em>&#91;ULF<em>A&#93;&quot; to give plots of that based on ULF</em>A only. The pattern should always begin with &quot;<em>&quot; and the last cahracter can never be &quot;</em>&quot;. For multiple filtering at once &#40;e.g., <code>&#39;*&#91;ULF_B&#93;*&#91;Tpred-1&#93;&#39;</code>&#41;, join the pattern with &quot;*&quot; and the order is important.</p>
</li>
</ul>
</div>



#### Fitting Degree and Molchan Diagram (`plotFittingDegree`)

<div class="markdown"><p><code>plotFittingDegree&#40;dir_jointstation,dir_catalog,dir_png&#41;</code> gives  fitting degree analysis and molchan diagrams for each  training-forecasting phase pair according to the results from <code>molscore3</code>.</p>
</div>


#### Visualization of 1-d EQK and TIP (`plotEQKTIP1`)

<div class="markdown"><p><code>plotEQKTIP1&#40;dir_tsAIN,dir_molchan,dir_catalog,dir_output&#41;</code> plot  one-dimensional TIP time series for each station with target earthquakes &#40;EQK&#41; scattered over the diagram; the results are saved as png files in <code>dir_output</code>.</p>
<p><strong>Keyword Arguments:</strong></p>
<ul>
<li><p>&#39;ShowTrainingPhase&#39;: Whether to show the EQK and TIP on the plot. Default is false. </p>
</li>
<li><p>&#39;scatter&#39;: Set it <code>true</code> to plot an additional layer of <code>TIP&#61;&#61;1</code> as scattered circles. This makes visually inspecting whether target earthquakes lay in the area of <code>TIP&#61;&#61;1</code> much easier. Default is <code>false</code>.</p>
</li>
<li><p>&#39;Rank&#39;: Choose the model by fitting degree ranking for defining EQK and TIP. Default is <code>1</code> &#40;plot the EQK and TIP that are defined by the rank 1 model&#41;.</p>
</li>
<li><p>&#39;OnlyStations&#39;: Specify only a subset of station to be displayed on the plot; for example, for <code>&#39;OnlyStations&#39;,&#123;&#39;MS&#39;,&#39;TW&#39;&#125;</code> only the results of these two stations will be displayed. In default, results of all stations will be displayed.</p>
</li>
<li><p>&#39;datetimeTickArguments&#39;: Manually define the datetime format of the X tick labels. For example, for <code>&#39;datetimeTickArguments&#39;, &#123;&quot;yy&#39; mmm.&quot;, 1,&#39;months&#39;&#125;</code> the datetime 2012-Nov-12 will be printed as &quot;12&#39; Nov.&quot;. For more information, see <code>datetime_ticks&#40;&#41;</code>.</p>
</li>
<li><p>&#39;TargetPattern&#39;: See the documentation in <code>plotProbability&#40;&#41;</code>.</p>
</li>
</ul>
</div>



### Others
#### Reconstruct `[Molchan]Information.mat` (`constructMolInfo`)

<div class="markdown"><p><code>constructMolInfo&#40;dir_molchan,InfoId&#41;</code> construct the &#39;&#91;MolchanScore&#93;Information.mat&#39; according to existing &#91;Molchanscore&#93;___.mat files if possible. Use this function only if instructed by error message.</p>
</div>



#### Calculating Fitting Degrees
##### `calcFittingDegree`

<div class="markdown"><p><code>calcFittingDegree&#40;jpathlist&#41;</code> according to the given files &#40;<code>jpathlist</code>&#41; provides the overall alarmed rate, missing rate that allows the calculation of the overall fitting degree.  Make sure to provide correct input list of the <code>&#91;JointStation&#93;</code> variable , for example, those have the same ID and are not overlapped in  forecasting time interval for each group;  otherwise the calculated fitting degree can be unreasonable.</p>
<p><strong>Example:</strong></p>
<pre><code class="language-matlab">dir_png &#61; &#39;D:\GoogleDrive\0MyResearch\CWB_project\CWB2021\Figures&#39;;
jpathlist &#61; datalist&#40;&#39;&#91;JointStation&#93;ID&#91;ou7ud&#93;prp&#91;ULF_B&#93;*.mat&#39;, dir_jointstation&#41;.fullpath;
&#91;AlarmedRate, MissingRate, xticklabel, EQKs, TIP3s, TIPv3s,TIPTimes,LatLons&#93; &#61; calcFittingDegree&#40;jpathlist&#41;;
FittingDegrees &#61; 1 - AlarmedRate - MissingRate;
plotEQKTIP3&#40;dir_png,prp_i, xlabels, EQKs, TIP3s, TIPv3s,TIPTimes, LatLons&#41;;</code></pre>
<p><strong>Input Arguments</strong>:</p>
<ul>
<li><p><code>jpathlist</code>: a cell array of the full paths of <code>&#91;JointStation&#93;</code> files that are produced by <code>molscore3</code>. You can simpliy obtain the path list by <code>jpathlist &#61; datalist&#40;&#39;&#91;JointStation&#93;ID&#91;ou7ud&#93;*prp&#91;ULF_A&#93;*slc&#91;Tpred-10&#93;*.mat&#39;,dir_jointstation&#41;.fullpath;</code></p>
</li>
</ul>
<p><strong>Keyword Arguments</strong>:</p>
<ul>
<li><p>&#39;GroupTag&#39;: The tag for grouping the files in <code>jpathlist</code>.</p>
</li>
<li><p>&#39;GroupNames&#39;: Results are calculated separately according to the assigned group names;  alarmed rate, missing rate and so on are only calculated if the file name contains the  assigned group names.  For example, for <code>...,&#39;GroupNames&#39;,&#123;&#39;Tpred-1&#39;, &#39;Tpred-5&#39;&#125;,&#39;GroupTag&#39;, &#39;slc&#39;,...</code>,  only the files with their names containing tag &#39;slc&#91;Tpred-1&#93;&#39; and &#39;slc&#91;Tpred-5&#93;&#39; are selected, and  the results of those being &#39;Tpred-1&#39; and &#39;Tpred-5&#39; are separately calculated. That is, the output <code>xlabel</code>  is <code>&#123;&#39;Tpred-1&#39;, &#39;Tpred-5&#39;&#125;</code> and other output arguments &#40;e.g. <code>AlarmedRate</code>&#41; are all cell array of the same  dimension as <code>xlabel</code> containing the results of the groups that are calculated separately. </p>
</li>
<li><p>Noted that You cannot assign &#39;GroupName&#39; without assigning &#39;GroupTag&#39;, but assigning &#39;GroupTag&#39; without assigning &#39;GroupName&#39; is OK, in this case the group names will automatically generated and sorted. </p>
</li>
</ul>
</div>



#### Retrieve Model Parameter (`get_modelparam`)

<div class="markdown"><p>Use <code>&#91;var1, var2, ...&#93; &#61; get_modelparam&#40;BestModels, &#39;name1&#39;, &#39;name2&#39;,...&#41;</code>  to get specific model parameters uniquely. <code>BestModels</code> is the output of <code>bestmodel&#40;&#41;</code>.</p>
<p><strong>Example:</strong></p>
<ul>
<li><p><code>Tpreds, Tleads &#61; get_modelparam&#40;BestModels, &#39;Tpred&#39;, &#39;Tlead&#39;&#41;</code></p>
</li>
</ul>
</div>



#### Confidence Boundary on the Molchan Diagram (`Molchan_CB`)

<div class="markdown"><p><code>&#91;molt_cb,moln_cb&#93; &#61; Molchan_CB&#40;N,alpha&#41;</code> gives the confidence boundary  in molchan diagram, where <code>&#91;molt_cb,moln_cb&#93;</code> are the points defining the boundary on the alarmed-rate-against-missing-rate phase plane. </p>
<p><strong>Input Arguments:</strong></p>
<ul>
<li><p><code>N</code>: total number of target events/earthquakes</p>
</li>
<li><p><code>alpha</code>: <code>1-alpha</code> is the confidence level. For example, <code>alpha&#61;0.05</code> means <code>95&#37;</code> confidence level.</p>
</li>
</ul>
<p><strong>Output Arguments:</strong></p>
<ul>
<li><p><code>molt_cb</code>: values corresponding to the alarmed rate</p>
</li>
<li><p><code>moln_cb</code>: values corresponding to the missing rate</p>
</li>
</ul>
<p><strong>Hint:</strong></p>
<ul>
<li><p>Calculate the &#36;D&#36; &#40;fitting degree&#41; values by <code>Dcb &#61; 1 - molt_cb - moln_cb</code></p>
</li>
</ul>
</div>



#### Generate an Organized directory Structure (`mkdir_default`)
In fact, all input/output directories can be arbitrarily assigned; we also provide a tool `mkdir_default` to automatically generate an organized directory structure.


<div class="markdown"><p><code>mkdir_default</code> creates/makes folders by default and return their  directories with default variable names. The default structure is:</p>
<pre><code>                   variable           default folder name
    ╔═ dir_main ═╤═══════════════════════════════════════╗
    ║            ├─dir_stat         &#61;   &#39;StatisticIndex&#39; ║
    ║            ├─dir_tsAIN        &#61;   &#39;tsAIN&#39;          ║
    ║            ├─dir_molchan      &#61;   &#39;MolchanScore&#39;   ║
    ║            └─dir_jointstation &#61;   &#39;JointStation&#39;   ║
    ╚════════════════════════════════════════════════════╝</code></pre>
<p><strong>Example:</strong> <code>&#91;dir_stat, dir_tsAIN, dir_molchan, dir_jointstation&#93; &#61; mkdir_default&#40;fullfile&#40;pwd,&#39;output_var&#39;&#41;&#41;</code></p>
</div>



#### Input/Output Directory Selection (`dirselectassign`)

<div class="markdown"><p><code>dirselectassign&#40;var_names...&#41;</code>  prompts user to select directories in a dialog box, and assigned the  selected path to workspace with default variable name. If a variable with the same name as the default name has already in the workspace, its assignment will be ignored &#40;i.e. its dialog box won&#39;t pop out&#41;. This is a tool for convenience. You can always assign directories  explicitly to variable with any name you like.</p>
<p><strong>Example:</strong></p>
<ul>
<li><p>Four windows will pop out one by one allowing you to assign directories to variables  <code>dir_stat</code>, <code>dir_tsAIN</code>, <code>dir_molchan</code>, <code>dir_jointstation</code>: </p>
<pre><code class="language-matlab">dirselectassign&#40;&#39;dir_stat&#39;,&#39;dir_tsAIN&#39;,&#39;dir_molchan&#39;,&#39;dir_jointstation&#39;&#41;;</code></pre>
<p>&#40;Read the printed message in the Command Window&#41;</p>
</li>
</ul>
<ul>
<li><p>Total 7 windows will pop out one by one allowing you to assign directories to the variables with default names <code>dir_stat</code>, <code>dir_tsAIN</code> , <code>dir_molchan</code>, <code>dir_jointstation</code>, <code>dir_data</code>, <code>dir_catalog</code>, <code>dir_toolbox</code>:</p>
<pre><code class="language-matlab">dirselectassign&#40;&#41;;</code></pre>
<p>&#40;Read the printed message in the Command Window&#41;</p>
</li>
</ul>
</div>
