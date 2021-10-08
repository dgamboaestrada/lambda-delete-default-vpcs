variable "prefix" {
  description = "(Optional) A prefix for all names resource of the module"
  type        = string
  default     = ""
}

variable "tags" {
  description = "(Optional) A map of tags by default to attach to the services"
  type        = map(string)
  default = {
    Project = "DeleteDefaultVPCs"
  }
}

variable "cloudwatch_logs_status" {
  type        = string
  description = "(Optional) Enable or diable cloudwatch logs. Values: ENABLED, DISABLED."
  default     = "ENABLED"
}

variable "logs_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain the cloudwatch log groups. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire"
  type        = number
  default     = 1
}

variable "notification_email" {
  description = "(Required) The email to send the notification"
  type        = string
}
