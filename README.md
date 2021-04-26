# README

The material in this replication package replicates the results of <i>Image Concerns in Pledges to Give Blood: Evidence from a Field Experiment</i> by Christian Johannes Meyer and Egon Tripodi. The master file <code>code/replication.do</code> run all of the code contained in <code>tables_and_figure/do_files/</code> to recreate all figures and tables from the paper. The data is confidential and cannot be made publicly available. However, the HTML file <code>replication.html</code> contains the dynamic output of all analyses conducted (i.e. the whole code along with the output generated through Stata/R).</p>
<p>If you find errors in the files or would like to run further analyses with this data, you are welcome to reach out to us. You can submit your code to Egon Tripodi (egon.tripodi@essex.ac.uk). We will run your code and return a dynamic document with all the outputs of your analyses.</p>


## Data Availability and Provenance Statements
<p>The data used for this project has been collected in the course of a field experiment, conducted in a mid-sized German city. The data are generated by means of a short survey and of the observed behavior of people involved (i.e. whether they pledge to donate and whether they donate with our partner organizations).</p>

## Dataset list

<p>Even if the data source is unique, for convenience of the analysis data have been split into 3 different datasets. Here below are listed the dataset used to carry out the whole analysis.</p>
<table style="text-align:left">
<thead style="text-align:center">
<tr class="header">
<th>Data file</th>
<th>Source</th>
<th>Notes</th>
<th>Provided</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>data_confidential/data_clean.dta</code></td>
<td>Field experiment</td>
<td>Contains the main treatment, outcome, and covariates variables. Used to replicate all figures and tables but Table A1 and Table D1. Confidential.</td>
<td>No</td>
</tr>
<tr class="even">
<td><code>data_confidential/choose_treatment.dta</code></td>
<td>Field experiment</td>
<td>Contains data related to the additional treatment described in Appendix D. Used to replicate Table D1. Confidential.</td>
<td>No</td>
</tr>
<tr class="even">
<td><code>data_confidential/data_table_a1.dta</code></td>
<td>Field experiment</td>
<td>Analogous to <code>data_clean.dta</code> but contains data also for people who did not participated or denied consent for the study. Used to replicate Table A1. Confidential.</td>
<td>No</td>
</tr>
</tbody>
</table>

## Computational requirements

<p>The whole analysis has been developed using Stata 16.0 and R 4.0.3 and, to the best of our knowledge, the code could be run on any computer machine with appropriate softwares installed.</p>
<p>Replicating all the results requires few minutes. However, exact computation time may vary according the specific computer machine used.</p>

### Software Requirements

<p>Here below are listed all the softwares used.</p>
<ul>
<li>Stata (code was last run with version 16.0)
<ul>
<li><code>cibar</code> (as of 2021-04-26)</li>
<li><code>coefplot</code> (as of 2021-04-26)</li>
<li><code>dm79</code> (as of 2021-04-26)</li>
<li><code>estout</code> (as of 2021-04-26)</li>
<li><code>kdens</code> (as of 2021-04-26)</li>
<li><code>lassopack</code> (as of 2021-04-26)</li>
<li><code>mixlogit</code> (as of 2021-04-26)</li>
<li><code>moremata</code> (as of 2021-04-26)</li>
<li><code>ralpha</code> (as of 2021-04-26)</li>
<li><code>rsource</code> (as of 2021-04-26)</li>
<li><code>semean</code> (as of 2021-04-26)</li>
<li><code>seq</code> (as of 2021-04-26)</li>
</ul></li>
</ul>
<ul>
<li>R (code was last run with version 4.0.3)
<ul>
<li><code>cowplot</code> (as of 2021-04-26)</li>
<li><code>DiagrammeR</code> (as of 2021-04-26)</li>
<li><code>dplyr</code> (as of 2021-04-26)</li>
<li><code>foreign</code> (as of 2021-04-26)</li>
<li><code>grf</code> (as of 2021-04-26)</li>
<li><code>haven</code> (as of 2021-04-26)</li>
<li><code>magrittr</code> (as of 2021-04-26)</li>
<li><code>rlang</code> (as of 2021-04-26)</li>
<li><code>tidyverse</code> (as of 2021-04-26)</li>
<li><code>xtable</code> (as of 2021-04-26)</li>
</ul></li>
</ul>

## Description of files

<p>Here below is provided a description of all the files in this replication package.</p>
<ul>
<li><code>code/do_files/</code> is the directory containing 10 Stata do-files, one to replicate each figure and table of the paper.</li>
<li><code>code/replication.do</code> is the master file that runs all the do-file contained in <code>code/do_files/</code> and produce all the figures and tables. As already mentioned, you are not expected to run this file as the data are not publicly available.</li>
<li><code>results/</code> is the directory where all the figures and tables produced by the analysis are stored.</li>
<li><code>logs/replication.smcl</code> is the log file produced by running <code>replication.do</code>. The log is already compiled, so that you can look at the commands execution without running the script.</li>
<li><code>replication.html</code> is the HTML containing the dynamic output. It contains the to code, together with the relevant output and the figures generated by the code, allowing you can observe code and output without the need of running the related do-file. Please notice this is an HTML file and some of its content are taken from other directories of the replication package, therefore if you make some changes (e.g. modifying or erasing some figures in <code>results/</code>, or moving <code>replication.html</code> to another directory) you may not visualize properly figures within <code>replcation.html</code>.</li>
<li><code>README.html</code> is this readme file.</li>
</ul>


## List of tables and programs

<p>Here is provided a list of all the figures and tables of the paper, together with the specific program generating each of them, the description of where to look for the output, and notes (if any). Please notice that for figures and tables that are not data-related no details are provided.</p>
<table style="text-align:left">
<thead style="text-align:center">
<tr class="header">
<th>Figure/Table</th>
<th>Program</th>
<th>Output</th>
<th>Note</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Figure 1</td>
<td><code>Figure 1.do</code></td>
<td><code>Figure_1.png</code></td>
<td></td>
</tr>
<tr class="even">
<td>Figure A1</td>
<td><code>n.a. (no data)</code></td>
<td><code></code></td>
<td></td>
</tr>
<tr class="odd">
<td>Figure B1</td>
<td><code>Figure B1.do</code></td>
<td><code>Figure_B1.png</code></td>
<td>This figure is generated using R, Stata is only used to run the R commands.</td>
</tr>
<tr class="even">
<td>Figure C1</td>
<td><code>n.a. (no data)</code></td>
<td><code></code></td>
<td></td>
</tr>
<tr class="odd">
<td>Figure C2</td>
<td><code>n.a. (no data)</code></td>
<td><code></code></td>
<td></td>
</tr>
<tr class="even">
<td>Figure C3</td>
<td><code>n.a. (no data)</code></td>
<td><code></code></td>
<td></td>
</tr>
<tr class="odd">
<td>Table 1</td>
<td><code>Table 1.do</code></td>
<td><code>Table_1.xlsx</code>,<br/> and console output</td>
<td></td>
</tr>
<tr class="even">
<td>Table 2</td>
<td><code>Table 2.do</code></td>
<td><code>Table_2.tex</code>,<br/> and console output</td>
<td></td>
</tr>
<tr class="odd">
<td>Table 3</td>
<td><code>Table 3.do</code></td>
<td><code>Table_3.tex</code>,<br/> and console output</td>
<td></td>
</tr>
<tr class="even">
<td>Table 4</td>
<td><code>Table 4.do</code></td>
<td>console output</td>
<td></td>
</tr>
<tr class="odd">
<td>Table A1</td>
<td><code>Table A1.do</code></td>
<td><code>Table_A1.xlsx</code>,<br/> and console output</td>
<td>Data in column 1 have been taken directly from Bonn City Government Statistical Office 2017 population statistics (<code>https://www2.bonn.de/statistik/dl/ews/Bevoelkerungsstatistik2017.pdf</code>)</td>
</tr>
<tr class="even">
<td>Table A2</td>
<td><code>Table A2.do</code></td>
<td><code>Table_A2.tex</code>,<br/> and console output</td>
<td></td>
</tr>
<tr class="odd">
<td>Table A3</td>
<td><code>Table A3.do</code></td>
<td><code>Table_A3.tex</code>,<br/> and console output</td>
<td></td>
</tr>
<tr class="even">
<td>Table D1</td>
<td><code>Table D1.do</code></td>
<td>console ouptut</td>
<td></td>
</tr>
</tbody>
</table>
