"
I am helper builder class used to create composite `=BlKeyCombination`=

Public API and Key Messages

- build finish combination creation and return result
- control add compulsory control key combination that alternatively matches both left and right control keys
- shift analog to control but adds shift
- meta analog to control but adds meta
- key: add compulsory combination consisting of a single Key
(advanced) cnf - resulting formula will be transformed to CNF (default)(https://en.wikipedia.org/wiki/Conjunctive_normal_form)
(advanced) dnf - resulting formula will be transformed to DNF (https://en.wikipedia.org/wiki/Disjunctive_normal_form)

Example:

   BlKeyCombinationBuilder new
	meta;
	shift;
	key: Key arrowUp;
	build

"
Class {
	#name : #BlKeyCombinationBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'combination'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> a [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey a)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> alt [
	| alt |

	alt := BlAlternativeCombination
		key: BlKeyboardKey altLeft
		or: BlKeyboardKey altRight.

	combination
		with: alt
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowDown [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey arrowDown)
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowLeft [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey arrowLeft)
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowRight [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey arrowRight)
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowUp [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey arrowUp)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> b [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey b)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> backspace [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey backspace)
]

{ #category : #builder }
BlKeyCombinationBuilder >> build [
	combination combinations size = 1
		ifTrue: [ ^ combination combinations first ].

	^ combination
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> c [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey c)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> control [
	| control |

	control := BlAlternativeCombination
		key: BlKeyboardKey controlLeft
		or: BlKeyboardKey controlRight.

	combination
		with: control
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> d [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey d)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> delete [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey delete)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> e [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey e)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> end [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey end)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> enter [
	combination
		with: ((BlSingleKeyCombination new key: BlKeyboardKey numpadEnter) 
			or: (BlSingleKeyCombination new key: BlKeyboardKey return))
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> equal [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey equal)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> escape [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey escape)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> f [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey f)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> g [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey g)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> home [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey home)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> i [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey i)
]

{ #category : #initialization }
BlKeyCombinationBuilder >> initialize [
	super initialize.
	
	combination := BlCompulsoryCombination new
]

{ #category : #accessing }
BlKeyCombinationBuilder >> key: aKey [

	combination
		with: (BlSingleKeyCombination new key: aKey)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> l [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey l)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> m [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey m)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> meta [
	| meta |

	meta := BlAlternativeCombination
		key: BlKeyboardKey metaLeft
		or: BlKeyboardKey metaRight.

	combination
		with: meta
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> minus [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey minus)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> n [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey n)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> numpadEnter [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey numpadEnter)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> p [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey p)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> primary [
	"I add a primary modifier to the key combination
	On Mac: Command.
	On Windows: Control
	On Linux: Control"
	
	combination with: OSPlatform current primaryModifier
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> q [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey q)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> r [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey r)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> return [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey return)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> s [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey s)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> secondary [
	"I add a secondary modifier to the key combination
	On Mac: Control.
	On Windows: Alt
	On Linux: Alt"

	combination with: OSPlatform current secondaryModifier
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> shift [
	| shift |

	shift := BlAlternativeCombination
		key: BlKeyboardKey shiftLeft
		or: BlKeyboardKey shiftRight.
		
	combination
		with: shift
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> space [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey space)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> t [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey t)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> tab [
	combination
		with: (BlSingleKeyCombination new key: BlKeyboardKey tab)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> v [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey v)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> w [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey w)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> x [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey x)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> y [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey y)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> z [
	combination with: (BlSingleKeyCombination new key: BlKeyboardKey z)
]
