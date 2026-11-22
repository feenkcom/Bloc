"
I am a scripter value check that compares the computed value with the expected one by content (see #sameContentAs:): a String and a Symbol with the same characters match.
I am created by TBlDevScripterCheckStep>>#value:sameContentAs:.
"
Class {
	#name : #BlDevScripterCheckElementValueSameContentStep,
	#superclass : #BlDevScripterCheckElementValueStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterCheckElementValueSameContentStep >> assertActual: anActualValue expected: anExpectedValue [
	"Compare the computed value with the expected one by content"

	self assert: anActualValue sameContentAs: anExpectedValue
]
