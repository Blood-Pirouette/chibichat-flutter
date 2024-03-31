class PromptClass {
  int? maxContextLength;
  int? maxLength;
  String? prompt;
  bool? quiet;
  double? repPen;
  int? repPenRange;
  int? repPenSlope;
  double? temperature;
  int? tfs;
  int? topA;
  int? topK;
  double? topP;
  int? typical;
  List<String>? stop_sequence;

  PromptClass({
    this.maxContextLength = 2048,
    this.maxLength = 100,
    this.prompt,
    this.quiet = false,
    this.repPen = 1.1,
    this.repPenRange = 256,
    this.repPenSlope = 1,
    this.temperature = 0.5,
    this.tfs = 1,
    this.topA = 0,
    this.topK = 0,
    this.topP = 0.9,
    this.typical = 1,
    this.stop_sequence = const ['</s>', '<s>', '[/INST]', '/n'],
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_context_length'] = this.maxContextLength;
    data['max_length'] = this.maxLength;
    data['prompt'] = this.prompt;
    data['quiet'] = this.quiet;
    data['rep_pen'] = this.repPen;
    data['rep_pen_range'] = this.repPenRange;
    data['rep_pen_slope'] = this.repPenSlope;
    data['temperature'] = this.temperature;
    data['tfs'] = this.tfs;
    data['top_a'] = this.topA;
    data['top_k'] = this.topK;
    data['top_p'] = this.topP;
    data['typical'] = this.typical;
    data['stop_sequence'] = this.stop_sequence;
    return data;
  }
}
