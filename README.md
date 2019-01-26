# SwipeButton
Swipe button for iOS

![picture](https://github.com/ktrkathir/SwipeButton/blob/master/Screen%20Shot%202019-01-26%20at%203.54.14%20PM.png)

Set Swipe button view
```ruby
var drawView = SwipeButtonView()
```

Swipe button handle action

```ruby
drawView.handleAction { (isFinished) in
print("isFinished: \(isFinished)")

if isFinished {
self.drawView.updateHint(text: "Success")
} else {
self.drawView.updateHint(text: "Draw Right")
}
}
```
