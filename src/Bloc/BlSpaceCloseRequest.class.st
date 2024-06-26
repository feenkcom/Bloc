"
I am a space close request sent by a windowing system asking a user application to handle a click on a window close button.

Close request can allow us to implement a dialog question asking if use actually want to close a window. If window indeed should be closed an event handler of close request should ask space explicitely:
```
space close
```

After that space sents an actual BlSpaceClosedEvent that indicates that windows was indeed closed

"
Class {
	#name : #BlSpaceCloseRequest,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'shouldClose'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #initialization }
BlSpaceCloseRequest >> initialize [
	super initialize.
	
	shouldClose := true
]

{ #category : #sending }
BlSpaceCloseRequest >> sendTo: anObject [
	anObject spaceCloseRequest: self
]

{ #category : #accessing }
BlSpaceCloseRequest >> shouldClose [
	^ shouldClose
]

{ #category : #accessing }
BlSpaceCloseRequest >> shouldClose: anObject [
	shouldClose := anObject
]
