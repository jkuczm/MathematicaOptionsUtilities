(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`DefineRequiredOptions`"];


(* ::Section:: *)
(*Tests*)


Module[
	{
		testFunction
	}
	,
	
	Test[
		DefineRequiredOptions[testFunction, "testStringOption"]
		,
		{
			"testStringOption" :>
				Message[
					testFunction::setOption,
					"testStringOption",
					testFunction
				]
		}
		,
		TestID -> "1 string option: definition"
	];
	
	testFunction[OptionsPattern[]] := OptionValue["testStringOption"];
	
	Test[
		testFunction[]
		,
		Null
		,
		{
			HoldForm @ Message[
				testFunction::setOption,
				"testStringOption",
				testFunction
			]
		}
		,
		TestID -> "1 string option: use without option"
	];
	
	Test[
		testFunction["testStringOption" -> "testOptionValue"]
		,
		"testOptionValue"
		,
		TestID -> "1 string option: use with option"
	];
];


Module[
	{
		testFunction1,
		testFunction2
	}
	,
	
	Test[
		DefineRequiredOptions[
			{testFunction1, testFunction2},
			"testStringOption"
		]
		,
		{
			{
				"testStringOption" :>
					Message[
						testFunction1::setOption,
						"testStringOption",
						testFunction1
					]
			}
			,
			{
				"testStringOption" :>
					Message[
						testFunction2::setOption,
						"testStringOption",
						testFunction2
					]
			}
		}
		,
		TestID -> "two symbols: 1 string option: definition"
	];
	
	testFunction1[OptionsPattern[]] := OptionValue["testStringOption"];
	testFunction2[OptionsPattern[]] := OptionValue["testStringOption"];
	
	Test[
		testFunction1[]
		,
		Null
		,
		{
			HoldForm @ Message[
				testFunction1::setOption,
				"testStringOption",
				testFunction1
			]
		}
		,
		TestID -> "two symbols (first): 1 string option: use without option"
	];
	Test[
		testFunction2[]
		,
		Null
		,
		{
			HoldForm @ Message[
				testFunction2::setOption,
				"testStringOption",
				testFunction2
			]
		}
		,
		TestID -> "two symbols (second): 1 string option: use without option"
	];
	
	Test[
		testFunction1["testStringOption" -> "testOptionValue"]
		,
		"testOptionValue"
		,
		TestID -> "two symbols (first): 1 string option: use with option"
	];
	Test[
		testFunction2["testStringOption" -> "testOptionValue"]
		,
		"testOptionValue"
		,
		TestID -> "two symbols (second): 1 string option: use with option"
	];
];


Module[
	{
		testFunction,
		testSymbolicOption
	}
	,
	
	Test[
		DefineRequiredOptions[testFunction, testSymbolicOption]
		,
		{
			testSymbolicOption :>
				Message[
					testFunction::setOption,
					testSymbolicOption,
					testFunction
				]
		}
		,
		TestID -> "1 symbolic option: definition"
	];
	
	testFunction[OptionsPattern[]] := OptionValue[testSymbolicOption];
	
	Test[
		testFunction[]
		,
		Null
		,
		{
			HoldForm @ Message[
				testFunction::setOption,
				testSymbolicOption,
				testFunction
			]
		}
		,
		TestID -> "1 symbolic option: use without option"
	];
	
	Test[
		testFunction[testSymbolicOption -> "testOptionValue"]
		,
		"testOptionValue"
		,
		TestID -> "1 symbolic option: use with option"
	];
];


Module[
	{
		testFunction,
		testSymbolicOption
	}
	,
	
	Test[
		DefineRequiredOptions[testFunction, testSymbolicOption, "testStringOption"]
		,
		{
			testSymbolicOption :>
				Message[
					testFunction::setOption,
					testSymbolicOption,
					testFunction
				]
			,
			"testStringOption" :>
				Message[
					testFunction::setOption,
					"testStringOption",
					testFunction
				]
		}
		,
		TestID -> "2 options symbolic, string: definition"
	];
	
	testFunction[OptionsPattern[]] := {
		OptionValue[testSymbolicOption],
		OptionValue["testStringOption"]
	};
	
	Test[
		testFunction[]
		,
		{Null, Null}
		,
		{
			HoldForm @ Message[
				testFunction::setOption,
				testSymbolicOption,
				testFunction
			]
			,
			HoldForm @ Message[
				testFunction::setOption,
				"testStringOption",
				testFunction
			]
		}
		,
		TestID -> "2 options symbolic, string: use without options"
	];
	
	Test[
		testFunction[testSymbolicOption -> "testOptionValue"]
		,
		{"testOptionValue", Null}
		,
		{
			HoldForm @ Message[
				testFunction::setOption,
				"testStringOption",
				testFunction
			]
		}
		,
		TestID -> "2 options symbolic, string: use with symbolic option"
	];
	
	Test[
		testFunction["testStringOption" -> "testOptionValue"]
		,
		{Null, "testOptionValue"}
		,
		{
			HoldForm @ Message[
				testFunction::setOption,
				testSymbolicOption,
				testFunction
			]
		}
		,
		TestID -> "2 options symbolic, string: use with string option"
	];
	
	Test[
		testFunction[
			"testStringOption" -> "testOptionValue",
			testSymbolicOption -> "testOptionValue"
		]
		,
		{"testOptionValue", "testOptionValue"}
		,
		TestID -> "2 options symbolic, string: use with both options"
	];
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
