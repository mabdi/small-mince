Class {
	#name : #BaselineOfTestGrinder,
	#superclass : #BaselineOf,
	#category : #BaselineOfTestGrinder
}

{ #category : #baselines }
BaselineOfTestGrinder >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'TestGrinder'.
			spec package: 'TestGrinder-Tests'
			with: [ spec requires: #( 'TestGrinder' ) ].
			spec group: 'core' with: #('TestGrinder').
			 ]
]
