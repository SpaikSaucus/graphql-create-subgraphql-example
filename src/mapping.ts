import {
  Joined as JoinedEvent,
  Created as CreatedEvent,
  Finished as FinishedEvent
} from "../generated/<SUBGRAPH_SLUG>/<SUBGRAPH_SLUG>";

import {
  Rating,
  User,
  Task
} from "../generated/schema";

import {
  Address,
  BigInt,
  ethereum,
  store
} from '@graphprotocol/graph-ts';


export function handleJoined(event: JoinedEvent): void {
  let entity = new User(event.params.user.toHex())
  entity.nickname = event.params.nickname

  entity.save()
}

export function handleCreated(event: CreatedEvent): void {
  let task = new Task(event.params.taskId);
  task.owner = event.params.owner.toHex();
  task.status = "NEW";
  task.details = event.params.details;
  task.save();
}

export function handleFinished(event: FinishedEvent): void {
  let taskId = event.params.taskId;
  let entity = Task.load(taskId);
  if (entity != null) {
    entity.status = "FINISHED";
    entity.resolver = event.params.resolver.toHex();
    entity.save();

    let rating = new Rating(taskId + '_' + entity.owner);
    rating.score = event.params.score;
    rating.taskId = taskId;
    rating.user = entity.owner;
    rating.save();
  }
}