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
		do: [ spec package: 'SmalltalkTestGrinder-Core'.
			spec package: 'SmalltalkTestGrinder-Tests'
			with: [ spec requires: #( 'SmalltalkTestGrinder-Core' ) ].
			spec group: 'core' with: #('SmalltalkTestGrinder-Core').
			spec group: 'tests' with: #('core' 'SmalltalkTestGrinder-Tests').
			 ]
]
