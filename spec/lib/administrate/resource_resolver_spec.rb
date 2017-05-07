require "spec_helper"
require "active_support/core_ext/string/inflections"
require "support/constant_helpers"
require "administrate/resource_resolver"

describe Administrate::ResourceResolver do
  describe "#dashboard_class" do
    it "handles global-namepsace models" do
      begin
        class AccountDashboard; end
        resolver = Administrate::ResourceResolver.new("admin/accounts")

        expect(resolver.dashboard_class).to eq(AccountDashboard)
      ensure
        remove_constants :AccountDashboard
      end
    end

    it "handles namespaced models" do
      begin
        module Library; class BookDashboard; end; end
        resolver = Administrate::ResourceResolver.new("admin/library/books")

        expect(resolver.dashboard_class).to eq(Library::BookDashboard)
      ensure
        remove_constants :Library
      end
    end
  end

  describe "#namespace" do
    it "returns the top-level namespace" do
      resolver = Administrate::ResourceResolver.new("foobar/user")

      expect(resolver.namespace).to eq("foobar")
    end
  end

  describe "#resource_class" do
    it "handles global-namepsace models" do
      begin
        class Account; end
        resolver = Administrate::ResourceResolver.new("admin/accounts")

        expect(resolver.resource_class).to eq(Account)
      ensure
        remove_constants :Account
      end
    end

    it "handles namespaced models" do
      begin
        module Library; class Book; end; end
        resolver = Administrate::ResourceResolver.new("admin/library/books")

        expect(resolver.resource_class).to eq(Library::Book)
      ensure
        remove_constants :Library
      end
    end
  end

  describe "#resource_title" do
    it "handles global-namepsace models" do
      resolver = Administrate::ResourceResolver.new("admin/accounts")

      expect(resolver.resource_title).to eq("Account")
    end

    it "handles namespaced models" do
      resolver = Administrate::ResourceResolver.new("admin/library/books")

      expect(resolver.resource_title).to eq("Library Book")
    end
  end

  describe "#resource_name" do
    it "handles global-namepsace models" do
      resolver = Administrate::ResourceResolver.new("admin/users")

      expect(resolver.resource_name).to eq(:user)
    end

    it "handles namespaced models" do
      resolver = Administrate::ResourceResolver.new("admin/library/books")

      expect(resolver.resource_name).to eq(:library__book)
    end
  end
end
