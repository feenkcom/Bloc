Class {
	#name : #BlDevScripterTarget,
	#superclass : #Object,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #factory }
BlDevScripterTarget class >> null [
	^ BlDevScripterNullTarget uniqueInstance
]

{ #category : #searching }
BlDevScripterTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #searching }
BlDevScripterTarget >> findTargetStartingInScripter: aScripter [
	^ self findTargetIn: aScripter element
]

{ #category : #accessing }
BlDevScripterTarget >> identifier [
	^ self className
]

{ #category : #accessing }
BlDevScripterTarget >> putTargetsInto: aWriteStream [
	"The collection is for the user exploratobility purposes.
	It should not be used in a production code, but rather reveal sequence of targets."

	^ aWriteStream nextPut: self
]

{ #category : #updating }
BlDevScripterTarget >> updateUsing: aScripterEventTarget on: aStep [
	aStep target: aScripterEventTarget
]
