     using { /Fortnite.com/Devices }
     using { /Verse.org/Simulation }

     hello_world_device := class(creative_device):

        @editable
        Button:button_device = button_device{}

        @editable
        ItemSpawner:item_spawner_device = item_spawner_device{}

        @editable
        GaurdSpawner:guard_spawner_device = guard_spawner_device{}

        

        # Container for storing the event subscription
        var ButtonSubscription:?cancelable = false

        OnBegin<override>()<suspends>:void=

            Subscription := Button.InteractedWithEvent.Subscribe(OnButtonInteractedWith)

            # Add the cancelable result to a spot in the Subscriptions array.
            set ButtonSubscription = option{Subscription}
            Print("Subscribed to the Button's InteractedWithEvent and assigned the subscription to ButtonSubscription!")

        OnButtonInteractedWith(InPlayer:agent):void=
            ItemSpawner.SpawnItem()
            GaurdSpawner.Spawn()
        OnEnd<override>() : void =
            # Access the cancelable variable for the InteractedWithEvent subscription
            if(CancelableResult := ButtonSubscription?):
                CancelableResult.Cancel()
                Print("Canceled this InteractedWithEvent")