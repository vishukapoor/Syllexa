  nv.addGraph(function () {
    var chart = nv.models.lineChart();
    
         chart.xAxis.axisLabel('Date');
        chart.xAxis
          .tickFormat(function(d) {
            return d3.time.format('%d-%m-%Y')(new Date(d))
          });

    chart.yAxis.axisLabel('Close')
        .tickFormat(d3.format(''));


    d3.select('#dateChart')
        .datum(chartData())
        .transition().duration(50)
        .call(chart);

    nv.utils.windowResize(function () {
        d3.select('#dateChart').call(chart)
    });

    return chart;
});


function chartData() {
    var myData = {
        "Date": [16379,16380,16381,16382,16383,16384,16385,16386,16387,16388,16389,16390,16391,16392,16393,16394,16395,16396,16397,16398,16399,16400,16401,16402,16403,16404,16405,16406,16407,16408,16409,16410,16411,16412,16413,16414,16415,16416,16417,16418,16419,16420,16421,16422,16423,16424,16425,16426,16427,16428,16429,16430,16431,16432,16433,16434,16435,16436,16437,16438,16439,16440,16441,16442,16443,16444,16448,16449,16450,16451,16452,16453,16454,16455,16456,16457,16458,16459,16460,16461,16462,16463,16464,16465,16466,16467,16468,16469,16470,16471,16472,16473,16474,16475,16476,16477,16478,16479,16480,16481,16482,16483,16484,16485,16486,16487,16488,16489,16490,16491,16492,16493,16494,16495,16496,16497,16498,16499,16500,16501,16502,16503,16504,16505,16506,16507,16508,16509,16510,16511,16512,16513,16514,16515,16516,16517,16518,16519,16520,16521,16522,16523,16524,16525,16526,16527,16528,16529,16530,16531,16532,16533,16534,16535,16536,16538,16539,16540,16541,16542,16543,16544,16545,16546,16547,16548,16549,16550,16551,16552,16553,16554,16555,16556,16557,16558,16559,16560,16561,16562,16563,16564,16565,16566,16567,16568,16569,16570,16571,16572,16573,16574,16575,16576,16577,16578,16579,16580,16581,16582,16583,16584,16585,16586,16587,16588,16589,16590,16591,16592,16593,16594,16595,16596,16597,16598,16599,16600,16601,16602,16603,16604,16605,16606,16607,16608,16609,16610,16611,16612,16613,16614,16615,16616,16617,16618,16619,16620,16621,16622,16623,16624,16625,16626,16627,16628,16629,16630,16631,16632,16633,16634,16635,16636,16637,16638,16639,16640,16641,16642,16643,16644,16645,16646,16647,16648,16649,16650,16651,16652,16653,16654,16655,16656,16657,16658,16659,16660,16661,16662,16663,16664,16665,16666,16667,16668,16669,16670,16671,16672,16673,16674,16675,16676,16677,16678,16679,16680,16681,16682,16683,16684,16685,16686,16687,16688,16689,16690,16691,16692,16693,16694,16695,16696,16697,16698,16699,16700,16701,16702,16703,16704,16705,16706,16707,16708,16709,16710,16711,16712,16713,16714,16715,16716,16717,16718,16719,16720,16721,16722,16723,16724,16725,16726,16727,16728,16729,16730,16731,16732,16733,16734,16735,16736,16737,16738,16739,16740,16741,16742,16743],
        "Close": [61.38,61.5005,61.41,61.41,61.475,61.495,61.56,61.4,61.57,61.73,61.73,61.77,61.805,61.74,61.9455,61.9305,61.69,61.69,61.7675,61.8605,61.85,61.7955,61.8605,62.24,62.24,62.2105,61.9555,61.7955,61.8635,61.915,61.865,61.865,61.865,61.875,62.04495,62.27895,62.52595,62.64495,62.64495,62.64495,63.62395,63.82395,63.31995,63.00095,63.34495,63.34495,63.34495,63.22495,63.39595,63.46945,63.47495,63.78545,63.78545,63.715,63.7,63.31995,63.16395,63.16495,63.24495,63.24495,63.24495,63.48445,63.514,63.14995,62.50795,62.305,61.96095,62.16895,61.90595,61.62095,61.62095,61.62095,61.66345,61.77595,61.54795,61.38995,61.39595,61.39595,61.39595,61.43395,61.38895,61.22995,61.78545,62.09695,62.09695,62.09695,61.75645,61.60045,61.81745,61.74645,62.04895,62.04895,62.04895,62.15745,62.32745,62.40645,62.14445,62.07995,62.07995,62.07995,62.23145,62.15745,62.08945,62.17445,62.13495,62.13495,62.13495,62.17645,61.96595,61.86045,61.73045,61.64395,61.64395,61.64395,61.90545,61.81945,62.28445,62.43845,62.78495,62.78495,62.78495,62.56645,62.835,62.76345,62.54145,63.09345,63.09345,63.09345,62.79045,62.62345,62.22095,62.49495,62.324,62.324,62.324,62.17295,62.26345,62.46045,62.84395,62.52945,62.52945,62.52945,62.51795,62.32,62.17645,62.104,61.92995,61.92995,61.93945,62.19945,62.31645,62.19145,62.32145,62.27195,62.27195,62.455,62.32145,62.36045,62.33745,62.54845,62.54845,62.54845,63.15345,62.88545,62.95845,63.26,63.77895,63.77895,63.77895,63.22995,63.05945,63.45345,63.58,63.72595,63.72595,63.72595,63.60145,63.35145,63.66445,64.09145,63.71145,63.71145,63.70495,64.02345,64.217,64.05345,63.41645,63.44245,63.44245,63.44245,63.73545,63.79145,63.63045,63.63245,63.49445,63.49445,63.49445,63.57845,63.98145,63.88345,63.83045,63.74745,63.74745,63.74745,63.61945,63.67145,64.06445,64.00145,64.10995,64.10995,64.10995,63.985,64.04745,63.80845,64.00545,64.09995,64.09995,64.09995,64.05845,64.18845,63.90545,63.65245,63.48095,63.48095,63.48095,63.51345,63.60545,63.56945,63.52045,63.45345,63.45345,63.48145,63.73445,63.61145,63.58345,63.37745,63.41745,63.41745,63.43345,63.37045,63.52645,63.56645,63.37245,63.37145,63.37145,63.37145,63.52145,63.33245,63.52945,63.49045,63.47495,63.47495,63.49145,63.63345,63.59045,63.66945,63.85345,64.10845,64.10845,64.10845,64.22345,63.84345,63.89145,64.12645,63.98645,63.98645,63.98645,64.13045,63.82345,63.725,63.73845,63.73745,63.73745,63.73745,63.84295,64.33545,64.80745,65.27445,65.13045,65.13045,65.13045,65.45545,65.52495,65.06145,65.46645,66.194,66.194,66.166,67.02995,66.336,66.06445,66.06245,66.15245,66.15245,66.15245,66.36045,66.43045,66.22045,66.16745,66.68645,66.68645,66.765,66.785,66.41445,66.61745,66.32545,66.24245,66.24245,66.24245,66.32445,66.43745,66.20245,66.13145,65.87045,65.87045,65.87045,65.68495,65.88145,66.17045,66.22845,66.16345,66.16345,66.2,66.36845,65.92845,65.53645,65.62545,65.21895,65.21895,65.21895,65.13145,65.19145,64.94545,65.00245,64.77745,64.77745,64.77945,64.78045,65.09345,64.85545,64.79245,64.70445,64.70445,64.70445,64.95945,65.00245,65.17145,65.05745,65.03145,65.03145,65.03145,64.92945,65.08545,65.24545,65.45045,65.42045,65.405,65.405,65.56445,65.53945,65.57945]        
    };

    var result = [];
    for (var i = 0; i < myData.Date.length; i++) {
        result.push({
            x: myData.Date[i],
            y: myData.Close[i]
        });
    }

    return [{
        values: result,
        key: 'Date Chart',
        color: '#2c567a'
    }];
}
