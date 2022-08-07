Class {
	#name : #SMDriverTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests'
}

{ #category : #tests }
SMDriverTest >> test1 [
| d o |
d := SMDriver new.
o := d md1: #ClassO.
o mo2.
o mo3.
d md2.
d md3: o
]

{ #category : #tests }
SMDriverTest >> test2 [

	| d o x |
	d := SMDriver new.
	o := d md1: #ClassO.
	o mo2.
	10 timesRepeat: [ o mo4 ].
	x := SMClassX new.
	x mx1.
	o mo5: x.
	o mo3.
	
]
