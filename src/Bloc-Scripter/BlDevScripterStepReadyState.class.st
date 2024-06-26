Class {
	#name : #BlDevScripterStepReadyState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepReadyState >> color [
	"BrGlamorousColors neutralBackgroundColor"
	^ (Color r: 0.9413489736070382 g: 0.9413489736070382 b: 0.9413489736070382 alpha: 1.0)
]

{ #category : #testing }
BlDevScripterStepReadyState >> isReady [
	^ true
]

{ #category : #accessing }
BlDevScripterStepReadyState >> name [
	^ 'ready'
]

{ #category : #accessing }
BlDevScripterStepReadyState >> priority [
	^ 95
]
