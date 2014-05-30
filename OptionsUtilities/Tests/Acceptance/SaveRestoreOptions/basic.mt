(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`Acceptance`SaveRestoreOptions`basic`"];


oldOptions = {"optName" -> "oldVal"};
newOptions = {"optName" -> "newVal"};


(* Define options for sym with "old" default values. *)
Options[sym] = oldOptions;


(* ::Section:: *)
(*Tests*)


(* Save old options. *)
SaveOptions[sym];


(* Set new options for sym. *)
SetOptions[sym, newOptions];
Test[
	Options[sym]
	,
	newOptions
	,
	TestID -> "sym has new options"
];


(* Restore old options. *)
RestoreOptions[];
Test[
	Options[sym]
	,
	oldOptions
	,
	TestID -> "sym has old options"
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
