Class {
	#name : #BaselineOfSmalltalkTestGrinder,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmalltalkTestGrinder
}

{ #category : #baselines }
BaselineOfSmalltalkTestGrinder >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'SmalltalkTestGrinder'.
			spec package: 'SmalltalkTestGrinder-Tests'
			with: [ spec requires: #( 'SmalltalkTestGrinder' ) ].
			spec group: 'core' with: #('SmalltalkTestGrinder').
			spec group: 'tests' with: #('core' 'SmalltalkTestGrinder-Tests').
			 ]
]
