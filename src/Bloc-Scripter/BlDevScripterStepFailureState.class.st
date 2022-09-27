Class {
	#name : #BlDevScripterStepFailureState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepFailureState >> color [
	"BrGlamorousColors errorBackgroundColor"
	^ (Color r: 1.0 g: 0.4701857282502444 b: 0.458455522971652 alpha: 1.0)
]

{ #category : #accessing }
BlDevScripterStepFailureState >> name [
	^ 'failed'
]

{ #category : #accessing }
BlDevScripterStepFailureState >> priority [
	^ 80
]

{ #category : #testing }
BlDevScripterStepFailureState >> wasExecuted [
	<return: #Boolean>
	^ true
]
