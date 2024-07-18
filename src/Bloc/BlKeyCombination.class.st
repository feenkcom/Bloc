"
I represent an abstract key combination which is the most important part of `=BlShortcut`=.
I define an event matching API that allows `=BlShortcutHandler`= to find the most appropriate shortcut for the currently pressed keys.

I support the Visitor pattern. See `=BlKeyCombinationVisitor`=

See `=BlKeyCombinationExamples`= for related examples.

"
Class {
	#name : #BlKeyCombination,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #'instance creation' }
BlKeyCombination class >> arrowDown [
	^ self builder arrowDown build
]

{ #category : #'instance creation' }
BlKeyCombination class >> arrowLeft [
	^ self builder arrowLeft build
]

{ #category : #'instance creation' }
BlKeyCombination class >> arrowRight [
	^ self builder arrowRight build
]

{ #category : #'instance creation' }
BlKeyCombination class >> arrowUp [
	^ self builder arrowUp build
]

{ #category : #'instance creation' }
BlKeyCombination class >> backspace [
	^ self builder backspace build
]

{ #category : #accessing }
BlKeyCombination class >> builder [
	^ BlKeyCombinationBuilder new
]

{ #category : #'instance creation' }
BlKeyCombination class >> delete [
	^ self builder delete build
]

{ #category : #'instance creation' }
BlKeyCombination class >> end [
	^ self builder end build
]

{ #category : #'instance creation' }
BlKeyCombination class >> enter [
	^ self return
]

{ #category : #'instance creation' }
BlKeyCombination class >> equal [
	^ self builder equal build
]

{ #category : #'instance creation' }
BlKeyCombination class >> escape [
	^ self builder escape build
]

{ #category : #'instance creation' }
BlKeyCombination class >> home [
	^ self builder home build
]

{ #category : #'instance creation' }
BlKeyCombination class >> minus [
	^ self builder minus build
]

{ #category : #'instance creation' }
BlKeyCombination class >> numpadEnter [
	^ self builder numpadEnter build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryA [
	"primary (Command/Control) + A"
	<return: #BlKeyCombination>

	^ self builder primary a build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryArrowLeft [
	^ self builder primary arrowLeft build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryArrowRight [
	^ self builder primary arrowRight build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryB [
	"primary (Command/Control) + B"
	<return: #BlKeyCombination>

	^ self builder primary b build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryC [
	"primary (Command/Control) + C"
	<return: #BlKeyCombination>

	^ self builder primary c build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryD [
	"primary (Command/Control) + D"
	<return: #BlKeyCombination>

	^ self builder primary d build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryE [
	"primary (Command/Control) + E"
	<return: #BlKeyCombination>

	^ self builder primary e build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryF [
	"primary (Command/Control) + F"
	<return: #BlKeyCombination>

	^ self builder primary f build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryG [
	"primary (Command/Control) + G"
	<return: #BlKeyCombination>

	^ self builder primary g build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryI [
	"primary (Command/Control) + I"
	<return: #BlKeyCombination>

	^ self builder primary i build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryL [
	"primary (Command/Control) + L"
	<return: #BlKeyCombination>

	^ self builder primary l build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryM [
	"primary (Command/Control) + M"
	<return: #BlKeyCombination>

	^ self builder primary m build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryN [
	"primary (Command/Control) + N"
	<return: #BlKeyCombination>

	^ self builder primary n build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryP [
	"primary (Command/Control) + P"
	<return: #BlKeyCombination>

	^ self builder primary p build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryQ [
	"primary (Command/Control) + Q"
	<return: #BlKeyCombination>

	^ self builder primary q build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryR [
	"primary (Command/Control) + R"
	<return: #BlKeyCombination>

	^ self builder primary r build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryReturn [
	"primary (Command/Control) + Return"
	<return: #BlKeyCombination>

	^ self builder primary numpadEnter build or: self builder primary return build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryS [
	"primary (Command/Control) + S"
	<return: #BlKeyCombination>

	^ self builder primary s build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftArrowLeft [
	^ self builder primary shift arrowLeft build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftArrowRight [
	^ self builder primary shift arrowRight build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftF [
	"primary (Command/Control) + Shift + F"
	<return: #BlKeyCombination>

	^ self builder primary shift f build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftG [
	"primary (Command/Control) + G"
	<return: #BlKeyCombination>

	^ self builder primary shift g build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftP [
	"primary (Command/Control) + Shift + P"
	<return: #BlKeyCombination>

	^ self builder primary shift p build
]

{ #category : #accessing }
BlKeyCombination class >> primaryShiftR [
	"primary (Command/Control) + Shift + R"
	<return: #BlKeyCombination>

	^ self builder primary shift r build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftZ [
	"primary (Command/Control) + Shift + Z"
	<return: #BlKeyCombination>

	^ self builder primary shift z build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryT [
	"primary (Command/Control) + T"
	<return: #BlKeyCombination>

	^ self builder primary t build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryV [
	"primary (Command/Control) + V"
	<return: #BlKeyCombination>

	^ self builder primary v build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryW [
	"primary (Command/Control) + W"
	<return: #BlKeyCombination>

	^ self builder primary w build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryX [
	"primary (Command/Control) + X"
	<return: #BlKeyCombination>

	^ self builder primary x build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryY [
	"primary (Command/Control) + Y"
	<return: #BlKeyCombination>

	^ self builder primary y build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryZ [
	"primary (Command/Control) + Z"
	<return: #BlKeyCombination>

	^ self builder primary z build
]

{ #category : #'instance creation' }
BlKeyCombination class >> return [
	^ self builder numpadEnter build or: self builder return build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftArrowDown [
	^ self builder shift arrowDown build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftArrowLeft [
	^ self builder shift arrowLeft build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftArrowRight [
	^ self builder shift arrowRight build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftArrowUp [
	^ self builder shift arrowUp build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftEnd [
	^ self builder shift end build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftHome [
	^ self builder shift home build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftReturn [
	"Shift + Return"
	<return: #BlKeyCombination>

	^ self builder shift return build
]

{ #category : #'instance creation' }
BlKeyCombination class >> shiftTab [
	"Shift + Tab"
	<return: #BlKeyCombination>

	^ self builder shift tab build
]

{ #category : #'instance creation' }
BlKeyCombination class >> space [
	^ self builder space build
]

{ #category : #'instance creation' }
BlKeyCombination class >> tab [
	^ self builder tab build
]

{ #category : #visiting }
BlKeyCombination >> accept: aKeyCombinationVisitor [
	^ self subclassResponsibility
]

{ #category : #controlling }
BlKeyCombination >> and: anotherKeyCombination [
	<return: #BlKeyCombination>

	^ BlCompulsoryCombination new
		with: self;
		with: anotherKeyCombination
]

{ #category : #converting }
BlKeyCombination >> asBufferKeys [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlKeyCombination >> gtDisplayOn: aStream [
	^ self printOn: aStream
]

{ #category : #'gt-inspector-extension' }
BlKeyCombination >> gtPreviewFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Combination';
		glamorousCodeFontAndSize;
		fontSize: 30;
		text: [ self printString ]
]

{ #category : #'key matching' }
BlKeyCombination >> includes: aKey [
	^ self subclassResponsibility
]

{ #category : #testing }
BlKeyCombination >> isAlternative [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isCompulsory [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isOnlyAlt [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isOnlyControl [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isOnlyMeta [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isOnlyReturnOrEnter [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isOnlyShift [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isSingleKey [
	^ false
]

{ #category : #'key matching' }
BlKeyCombination >> match: aKeyboardBuffer [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'key matching' }
BlKeyCombination >> matches: aKeyboardBuffer [
	<return: #Boolean>
	
	self
		deprecated: 'Please use matchesKeyBuffer: instead.'
		transformWith:
			'`@receiver matches: `@statements1'
 		-> '`@receiver matchesKeyBuffer: `@statements1'.

	^ self matchesKeyBuffer: aKeyboardBuffer
]

{ #category : #'key matching' }
BlKeyCombination >> matchesKeyBuffer: aKeyboardBuffer [
	"This is the root method that should be used when shortcut tries to exactly match a keyboard buffer with a key combination"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #controlling }
BlKeyCombination >> or: anotherKeyCombination [
	<return: #BlKeyCombination>

	^ BlAlternativeCombination
		combination: self
		or: anotherKeyCombination
]

{ #category : #'key matching' }
BlKeyCombination >> partiallyMatchesKeyBuffer: aKeyboardBuffer [
	"Return true if the key combination partially matches the key buffer"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #printing }
BlKeyCombination >> storeOn: aStream [
	self subclassResponsibility
]
