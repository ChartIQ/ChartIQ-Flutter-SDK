const String shortName = 'ATR Trailing Stops',
    name = 'ATR Trailing Stops',
    display = '',
    range = '',
    studyType = '';
const double centerLine = 0.0;
const bool signalIQExclude = false,
    customRemoval = false,
    deferUpdate = false,
    overlay = true,
    underlay = false;
const Map<String, dynamic> inputs = {
  'HighLow': 0,
  'Multiplier': 3,
  'Period': 21,
  'Plot Type': [
    'points',
    'square',
  ]
},
    outputs = {'Buy Stops': '#FF0000', 'Sell Stops': '#00FF00'},
    parameters = {
      'init': {
        'studyOverBoughtColor': 'auto',
        'studyOverBoughtValue': 100,
        'studyOverSoldColor': 'auto',
        'studyOverSoldValue': '-100',
        'studyOverZonesEnabled': 1
      },
    },
    attributes = {
      'Multiplier': {'min': 0.1, 'step': 0.1}
    },
    yAxis = {'': ''};

const Map<String, dynamic> studyJson = {
  'shortName': shortName,
  'name': name,
  'centerLine': centerLine,
  'display': display,
  'range': range,
  'type': studyType,
  'signalIQExclude': signalIQExclude,
  'customRemoval': customRemoval,
  'deferUpdate': deferUpdate,
  'overlay': overlay,
  'underlay': underlay,
  'yAxis': yAxis,
  'attributes': attributes,
  'inputs': inputs,
  'outputs': outputs,
  'parameters': parameters,
};