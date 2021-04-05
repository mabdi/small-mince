Class {
	#name : #TGMinimizer,
	#superclass : #Object,
	#instVars : [
		'theTrace'
	],
	#category : #'TestGrinder-2.Minimizer'
}

{ #category : #building }
TGMinimizer >> compose [ 
	"1. Filter all records calling theMethod on theClass"
	"2. add all records related to the selected objects"
	"3. add all dependencies related to the selected objects (recersive)"
]
