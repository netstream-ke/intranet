// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
import ThreadController from "./thread_controller"
import CommentsController from "./comments_controller"
import ReplyController from "./reply_controller"
application.register("thread", ThreadController)
application.register("reply", ReplyController)

import CommentsController from "./comments_controller"
application.register("comments", CommentsController)
import AutocompleteController from "./autocomplete_controller"
application.register("autocomplete", AutocompleteController)
