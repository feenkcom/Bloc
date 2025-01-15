"
I define whether a first {{gtClass:BlElement}} child is considered a (context menu) handle or regular (context) menu element.

"
Class {
	#name : #BlSteppedHandle,
	#superclass : #Object,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #'instance creation' }
BlSteppedHandle class >> center [
	^ BlSteppedCenterHandle new
]

{ #category : #'instance creation' }
BlSteppedHandle class >> null [
	^ BlSteppedNoHandle new
]

{ #category : #'instance creation' }
BlSteppedHandle class >> topLeft [
	^ BlSteppedTopLeftHandle new
]

{ #category : #measure }
BlSteppedHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	self subclassResponsibility
]
