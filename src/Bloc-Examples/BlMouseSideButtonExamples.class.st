Class {
	#name : #BlMouseSideButtonExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples'
}

{ #category : #'examples - back and forward' }
BlMouseSideButtonExamples >> backButton [
  <gtExample>
  <return: #BlMouseBackButton>
  | button |
  button := BlMouseButton back.
  self assert: button class equals: BlMouseBackButton.
  ^button
]

{ #category : #'examples - back and forward' }
BlMouseSideButtonExamples >> forwardButton [
  <gtExample>
	<return: #BlMouseForwardButton>
	| button |
	button := BlMouseButton forward.
	self assert: button class equals: BlMouseForwardButton.
	^button
]

{ #category : #'examples - back and forward' }
BlMouseSideButtonExamples >> backButtonIsSingleton [
  <gtExample>
	<return: #BlMouseBackButton>
	| a b |
	a := BlMouseButton back.
	b := BlMouseButton back.
	self assert: a == b.
	^a
]

{ #category : #'examples - back and forward' }
BlMouseSideButtonExamples >> forwardButtonIsSingleton [
  <gtExample>
	<return: #BlMouseForwardButton>
	| a b |
	a := BlMouseButton forward.
	b := BlMouseButton forward.
	self assert: a == b.
	^a
]

{ #category : #'examples - back and forward' }
BlMouseSideButtonExamples >> backNotEqualToForward [
  <gtExample>
	<return: #BlMouseBackButton>
	| back forward |
	back := BlMouseButton back.
	forward := BlMouseButton forward.
	self assert: (back = forward) not.
	self assert: back hash ~= forward hash.
	^back
]

{ #category : #'examples - convert button' }
BlMouseSideButtonExamples >> convertButtonBack [
  <gtExample>
	<return: #BlMouseBackButton>
	| glutinButton result |
	glutinButton := GlutinEventMouseButton new.
	glutinButton button_type: WinitEventMouseButtonType Back.
	glutinButton button_code: 0.
	result := BlRustWindowingHostSpace new convertButton: glutinButton.
	self assert: result equals: BlMouseButton back.
	^result
]

{ #category : #'examples - convert button' }
BlMouseSideButtonExamples >> convertButtonForward [
  <gtExample>
	<return: #BlMouseForwardButton>
	| glutinButton result |
	glutinButton := GlutinEventMouseButton new.
	glutinButton button_type: WinitEventMouseButtonType Forward.
	glutinButton button_code: 0.
	result := BlRustWindowingHostSpace new convertButton: glutinButton.
	self assert: result equals: BlMouseButton forward.
	^result
]
