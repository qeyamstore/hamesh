CREATE TABLE `ad_links` (
	`id` text PRIMARY KEY NOT NULL,
	`workspace_id` text NOT NULL,
	`provider` text NOT NULL,
	`secret` text NOT NULL,
	`account` text,
	`currency` text,
	`last_sync` text,
	`status` text DEFAULT 'connected' NOT NULL
);
--> statement-breakpoint
CREATE TABLE `ad_states` (
	`id` text PRIMARY KEY NOT NULL,
	`owner_id` text NOT NULL,
	`workspace_id` text NOT NULL,
	`provider` text NOT NULL,
	`expires` integer NOT NULL
);
