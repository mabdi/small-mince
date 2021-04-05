Class {
	#name : #TGProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'method',
		'action'
	],
	#category : #'TestGrinder-1.Tracer'
}

{ #category : #'as yet unclassified' }
TGProxy class >> cureClass: aClass [
	aClass methodDict values
		select: [ :x | x class = self ]
		thenDo: [ :x | self cureMethod: x ]
]

{ #category : #'as yet unclassified' }
TGProxy class >> cureMethod: aMethod [
	| m |
	m := aMethod.
	[ m method class = self ] whileTrue: [ m := m method ].
	m uninstall
]

{ #category : #'as yet unclassified' }
TGProxy class >> on: aCompiledMethod action: action [
	"Initialize the method tracer on aCompiledMethod and returns the method tracer.
     Do not install the tracer. You need to explicitely call #install on the instance returned to install it.
    "

	^ self basicNew initializeOn: aCompiledMethod action: action
]

{ #category : #'reflective operations' }
TGProxy >> doesNotUnderstand: aMessage [
	"Messages not understood by myself are forwarded to the CompiledMethod I hold."

	^ method perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #'reflective operations' }
TGProxy >> gtDisplayString [
	^ 'TGProxy'
]

{ #category : #'reflective operations' }
TGProxy >> initializeOn: aCompiledMethod action: anObject [
	aCompiledMethod class = CompiledMethod
		ifFalse: [ Error new signal: 'cannot install proxy on other object' ].
	action := anObject.
	method := aCompiledMethod
]

{ #category : #'reflective operations' }
TGProxy >> install [
	"Install myself instead of the CompiledMethod in the class holding it.
     This way, when sending a message to the CompiledMethod (to execute it for example)
     I am notified and I can remember that the method was run.
    "

	method methodClass methodDict at: method selector put: self
]

{ #category : #'reflective operations' }
TGProxy >> method [
	^ method
]

{ #category : #'reflective operations' }
TGProxy >> printOn: aStream [
	aStream nextPutAll: 'TGProxy'
]

{ #category : #evaluation }
TGProxy >> run: aSelector with: anArray in: aReceiver [
	| result |
	action preCall: aSelector with: anArray in: aReceiver.
	[ result := aReceiver withArgs: anArray executeMethod: method ]
		on: Error
		do: [ :x | (':' join: {'Error'. x class name}) traceCr  ].
	action
		postCall: aSelector
		with: anArray
		in: aReceiver
		result: result.
	^ result
]

{ #category : #'as yet unclassified' }
TGProxy >> tg_internal_class [
	^ true
]

{ #category : #evaluation }
TGProxy >> uninstall [
	"Put the CompiledMethod I replaced back to its place.
     After this method has been executed, I do not receive CompiledMethod's
     messages before forwarding them to it anymore.
    "

	method methodClass methodDict at: method selector put: method
]
