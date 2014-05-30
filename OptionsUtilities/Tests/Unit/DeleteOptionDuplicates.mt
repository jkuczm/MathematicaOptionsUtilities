(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`DeleteOptionDuplicates`"];


(* ::Section:: *)
(*Tests*)


Test[
	DeleteOptionDuplicates["opt1" -> "opt1Val"]
	,
	{"opt1" -> "opt1Val"}
	,
	TestID -> "one option"
];
Test[
	DeleteOptionDuplicates["opt1" -> "opt1Val", "opt2" -> "opt2Val"]
	,
	{"opt1" -> "opt1Val", "opt2" -> "opt2Val"}
	,
	TestID -> "two different options"
];
Test[
	DeleteOptionDuplicates["opt1" -> "opt1Val", "opt1" -> "opt1Val"]
	,
	{"opt1" -> "opt1Val"}
	,
	TestID -> "two options same names same values"
];
Test[
	DeleteOptionDuplicates["opt1" -> "opt1Val1", "opt1" -> "opt1Val2"]
	,
	{"opt1" -> "opt1Val1"}
	,
	TestID -> "two options same names different values"
];
Test[
	DeleteOptionDuplicates[
		{"opt2" -> "opt2Val1", {"opt1" -> "opt1Val1", "opt2" -> "opt2Val2"}},
		"opt1" -> "opt1Val2"
	]
	,
	{"opt2" -> "opt2Val1", "opt1" -> "opt1Val1"}
	,
	TestID -> "options with same names and different values on different \
levels"
];
TestMatch[
	DeleteOptionDuplicates["non-option", "opt1" -> "opt1Val2"]
	,
	HoldPattern[DeleteOptionDuplicates["non-option", "opt1" -> "opt1Val2"]]
	,
	TestID -> "non-option argument"
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
