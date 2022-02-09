Class {
	#name : #BlExamplePropagatableProperty,
	#superclass : #BlElementProperty,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'api - property' }
BlExamplePropagatableProperty >> applyOnElement: anElement [
	anElement background: Color red.
	anElement userData at: #exampleProperty put: true
]

{ #category : #testing }
BlExamplePropagatableProperty >> canPropagateToChildren [
	^ true
]
