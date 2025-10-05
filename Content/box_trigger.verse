
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
box_trigger := class(creative_device):

    @editable
    TriggerDevice:trigger_device = trigger_device{}

   var TriggerSubscription : ?cancelable = false
 
    OnBegin<override>()<suspends>:void =
        # Subscribe to the trigger's TriggeredEvent
        set TriggerSubscription = option{TriggerDevice.TriggeredEvent.Subscribe(OnTriggerActivated)}
 
    # Event handler for the trigger
    OnTriggerActivated(Agent:?agent):void =
        Print("Trigger activated!")
 
    # Optional: Unsubscribe when the device ends
    OnEnd<override>():void =
        if (Subscription := TriggerSubscription?):
            Subscription.Cancel()

